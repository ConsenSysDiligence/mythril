pragma solidity 0.8.25;

contract Generosity {
    mapping(address => bool) sentGifts;

    modifier nonreentrant {
        uint x;
        assembly {
            x := tload(0)
        }
        assert (x == 0);
        assembly {
            if tload(0) { revert(0, 0) }
            tstore(0, 1)
        }
        _;
        // Unlocks the guard, making the pattern composable.
        // After the function exits, it can be called again, even in the same transaction.
        assembly {
            x := tload(0)
        }
        // It should be same as before, i.e., 1
        assert (x == 1);

        assembly {
            tstore(0, 0)
        }
        assembly {
            x := tload(0)
        }
        // resets to 0
        assert (x == 0);
    }

    function claimGift() nonreentrant public {
        require(address(this).balance >= 1 ether);
        require(!sentGifts[msg.sender]);
        (bool success, ) = msg.sender.call{value: 1 ether}("");
        require(success);

        // In a reentrant function, doing this last would open up the vulnerability
        sentGifts[msg.sender] = true;
        
        // Make an internal call
        internalCall();
    }

    // Internal function to make a recursive internal call
    function internalCall() internal {
        if (address(this).balance >= 1 ether) {
            claimGift();
        }
    }

    // Function to receive Ether
    receive() external payable {}
}
