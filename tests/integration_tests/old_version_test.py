import json

import pytest
from utils import output_of

from tests import PROJECT_DIR, TESTDATA

MYTH = str(PROJECT_DIR / "myth")
test_data = (
    ("old_origin.sol", 1),
    ("old_version.sol", 2),
)


@pytest.mark.parametrize("file_name, issues", test_data)
def test_analysis_old(file_name, issues):
    file = str(TESTDATA / "input_contracts" / file_name)
    command = f"python3 {MYTH} analyze {file} -o jsonv2"
    output = json.loads(output_of(command))
    assert len(output[0]["issues"]) >= issues
