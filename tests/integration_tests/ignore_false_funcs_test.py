import pytest
from utils import output_of

from tests import PROJECT_DIR, TESTDATA

MYTH = str(PROJECT_DIR / "myth")

test_data = [
    (f"{TESTDATA}/input_contracts/base_case.sol", "0x83197ef0"),
]


@pytest.mark.parametrize("file_name, ignore_func", test_data)
def test_ignore_false_funcs(file_name, ignore_func):
    print(file_name)
    output = output_of(f"{MYTH} a {file_name} --ignore-false-funcs [{ignore_func}]")
    assert "Function name: destroy()" not in output
