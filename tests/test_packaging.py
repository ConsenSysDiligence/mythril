"""Tests for the build system migration (setup.py → pyproject.toml + uv).

These tests verify that version resolution, package metadata, and build
plumbing actually work — things that break silently when migrating build
systems.
"""

import re
import subprocess
import sys
from importlib.metadata import metadata
from pathlib import Path

import pytest

PROJECT_DIR = Path(__file__).parent.parent
PYPROJECT_TOML = PROJECT_DIR / "pyproject.toml"


# ---------------------------------------------------------------------------
# Version format & consistency
# ---------------------------------------------------------------------------


class TestVersion:
    """Version string must be PEP 440 and consistent across all access paths.

    setuptools dynamic version reads from mythril.__version__.__version__.
    The CLI imports it separately.  The release workflow reads it via exec().
    If any of these diverge, releases break.
    """

    def test_version_is_pep440(self):
        from mythril.__version__ import __version__

        # PEP 440: N.N.N with optional pre/post/dev suffixes
        pattern = r"^\d+\.\d+\.\d+([._]?(dev|a|b|rc|post)\d+)*$"
        assert re.match(pattern, __version__), (
            f"__version__ {__version__!r} is not PEP 440 compliant. "
            "setuptools will reject it during build."
        )

    def test_version_consistent_across_imports(self):
        """All code paths that expose the version must agree."""
        from mythril.__version__ import __version__
        from mythril import VERSION
        from mythril.interfaces.cli import VERSION as CLI_VERSION

        assert VERSION == __version__
        assert CLI_VERSION == __version__

    def test_version_readable_by_exec(self):
        """The release-pypi workflow reads version via exec().

        If __version__.py ever gains top-level imports or side effects,
        this exec()-based read breaks the release pipeline silently.
        """
        result = subprocess.run(
            [
                sys.executable,
                "-c",
                "exec(open('mythril/__version__.py').read()); print(__version__)",
            ],
            capture_output=True,
            text=True,
            cwd=str(PROJECT_DIR),
        )
        assert result.returncode == 0
        from mythril.__version__ import __version__

        assert result.stdout.strip() == __version__

    def test_installed_metadata_version_matches(self):
        """The version in installed package metadata must match __version__.

        This is the actual proof that pyproject.toml's dynamic version
        wiring (setuptools reading mythril.__version__.__version__) works.
        """
        from mythril.__version__ import __version__

        pkg_meta = metadata("mythril")
        assert pkg_meta["Version"] == __version__


# ---------------------------------------------------------------------------
# Entry point resolution
# ---------------------------------------------------------------------------


class TestEntryPoint:
    """The 'myth' CLI entry point must resolve to an importable callable.

    If the entry point string in pyproject.toml has a typo or the target
    function is moved/renamed, `myth` silently stops working after install.
    """

    def test_entry_point_importable(self):
        from mythril.interfaces.cli import main

        assert callable(main)

    def test_entry_point_in_installed_metadata(self):
        """Verify the installed package actually registered the console script."""
        from importlib.metadata import entry_points

        eps = entry_points()
        # Python 3.12+ returns a SelectableGroups, older returns dict
        if hasattr(eps, "select"):
            myth_eps = eps.select(group="console_scripts", name="myth")
        else:
            myth_eps = [
                ep for ep in eps.get("console_scripts", []) if ep.name == "myth"
            ]
        myth_eps = list(myth_eps)
        assert len(myth_eps) == 1, (
            "Expected exactly one 'myth' console_script entry point"
        )
        assert myth_eps[0].value == "mythril.interfaces.cli:main"


# ---------------------------------------------------------------------------
# Docker dependency extraction logic
# ---------------------------------------------------------------------------


class TestDockerDepsExtraction:
    """The Dockerfile has inline Python that parses pyproject.toml to extract
    dependencies, filtering out blake2b and z3-solver (built separately).

    If pyproject.toml's structure changes (e.g., dependencies key moves),
    the Docker build silently produces a broken image with missing packages.
    This test runs the same logic to catch that.
    """

    def test_extraction_produces_valid_filtered_list(self):
        if sys.version_info >= (3, 11):
            import tomllib
        else:
            try:
                import tomllib
            except ModuleNotFoundError:
                import tomli as tomllib

        with open(PYPROJECT_TOML, "rb") as f:
            data = tomllib.load(f)

        # This is the exact logic from the Dockerfile's inline script
        deps = data["project"]["dependencies"]
        filtered = [
            d
            for d in deps
            if "blake2b" not in d.lower() and "z3-solver" not in d.lower()
        ]

        # The two special-cased deps must be excluded
        for d in filtered:
            assert "blake2b" not in d.lower()
            assert "z3-solver" not in d.lower()

        # blake2b and z3-solver must still be in the full list (they're
        # built in separate Docker stages — removing them from pyproject.toml
        # would break the non-Docker install)
        all_deps_lower = " ".join(d.lower() for d in deps)
        assert "blake2b" in all_deps_lower, "blake2b missing from dependencies"
        assert "z3-solver" in all_deps_lower, "z3-solver missing from dependencies"

        # Filtered list must still contain the bulk of dependencies
        assert len(filtered) > 0, "Docker dep extraction returned empty list"
