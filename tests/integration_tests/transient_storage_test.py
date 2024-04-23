import pytest
from unittest.mock import patch, MagicMock
import json
import sys

from subprocess import STDOUT
from tests import PROJECT_DIR, TESTDATA
from utils import output_of

MYTH = str(PROJECT_DIR / "myth")

input_files = [
    ("transient.sol", False),
    ("transient_bug.sol", True),
    ("transient_bug_2.sol", True),
    ("transient_recursive.sol", True),
]


@pytest.mark.parametrize("file_name, expected_has_bug", input_files)
def test_positive_solc_settings(file_name, expected_has_bug):
    file_path = str(TESTDATA / "input_contracts" / file_name)

    # Call the function you want to test
    command = f"python3 {MYTH} analyze {file_path} -mExceptions --solv 0.8.25"
    actual_output = output_of(command)

    # Assertion
    if expected_has_bug:
        assert "An assertion violation was triggered" in actual_output
    else:
        assert (
            "The analysis was completed successfully. No issues were detected"
            in actual_output
        )
