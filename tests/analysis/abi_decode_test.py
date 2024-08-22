import pytest

from mythril.analysis.report import Issue

test_data = (
    (
        "0xa9059cbb000000000000000000000000010801010101010120020101020401010408040402",
        "func(uint256,uint256)",
        (
            5887484186314823854737699484601117092168074244,
            904625697166532776746648320380374280103671755200316906558262375061821325312,
        ),
    ),
    (
        "0xa9059cbb00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000002",
        "func(uint256,uint256)",
        (2, 2),
    ),
    # location + length + data
    (
        "0xa9059cbb" + "0" * 62 + "20" + "0" * 63 + "1" + "0" * 63 + "2",
        "func(uint256[])",
        ((2,),),
    ),
)


@pytest.mark.parametrize("call_data, signature, expected", test_data)
def test_abi_decode(call_data, signature, expected):
    assert Issue.resolve_input(call_data, signature) == expected
