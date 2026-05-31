/**
 *Submitted for verification at Etherscan.io on 2019-09-22
*/

pragma solidity >=0.5.11;

// * Gods Unchained Raffle Token Exchange
//
// * Version 1.0
//
// * A dedicated contract for listing (selling) and buying raffle tokens.
//
// * https://gu.cards

contract ERC20Interface {
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
function bug_intou7() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
}

contract IERC20Interface {
    function allowance(address owner, address spender) external view returns (uint256);
function bug_intou23() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
    function balanceOf(address account) external view returns (uint256);
mapping(address => uint) balances_intou14;

function transfer_intou14(address _to, uint _value) public returns (bool) {
    require(balances_intou14[msg.sender] - _value >= 0);  //bug
    balances_intou14[msg.sender] -= _value;  //bug
    balances_intou14[_to] += _value;  //bug
    return true;
  }
}

contract RaffleToken is ERC20Interface, IERC20Interface {}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath: modulo by zero");
        return a % b;
    }
}

contract RaffleTokenExchange {
    using SafeMath for uint256;

    //////// V A R I A B L E S
    //
    // The raffle token contract
    //
    RaffleToken constant public raffleContract = RaffleToken(0x0C8cDC16973E88FAb31DD0FCB844DdF0e1056dE2);
    //
    // In case the exchange is paused.
    //
  function bug_intou19() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  bool public paused;
    //
    // Standard contract ownership.
    //
  mapping(address => uint) balances_intou26;

function transfer_intou26(address _to, uint _value) public returns (bool) {
    require(balances_intou26[msg.sender] - _value >= 0);  //bug
    balances_intou26[msg.sender] -= _value;  //bug
    balances_intou26[_to] += _value;  //bug
    return true;
  }
  address payable public owner;
    //
    // Next id for the next listing
    //
  function bug_intou20(uint8 p_intou20) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou20;   // overflow bug
}
  uint256 public nextListingId;
    //
    // All raffle token listings mapped by id
    //
  function bug_intou32(uint8 p_intou32) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou32;   // overflow bug
}
  mapping (uint256 => Listing) public listingsById;
    //
    // All purchases
    //
  mapping(address => uint) balances_intou38;

function transfer_intou38(address _to, uint _value) public returns (bool) {
    require(balances_intou38[msg.sender] - _value >= 0);  //bug
    balances_intou38[msg.sender] -= _value;  //bug
    balances_intou38[_to] += _value;  //bug
    return true;
  }
  mapping (uint256 => Purchase) public purchasesById;
    //
    // Next id for the next purche
    //
  function bug_intou4(uint8 p_intou4) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou4;   // overflow bug
}
  uint256 public nextPurchaseId;

    //////// S T R U C T S
    //
    //  A listing of raffle tokens
    //
    struct Listing {
        //
        // price per token (in wei).
        //
        uint256 pricePerToken;
        //
        //
        // How many tokens? (Original Amount)
        //
        uint256 initialAmount;
        //
        // How many tokens left? (Maybe altered due to partial sales)
        //
        uint256 amountLeft;
        //
        // Listed by whom?
        //
        address payable seller;
        //
        // Active/Inactive listing?
        //
        bool active;
    }
    //
    //  A purchase of raffle tokens
    //
    struct Purchase {
        //
        // How many tokens?
        //
        uint256 totalAmount;
        //
        // total price payed
        //
        uint256 totalAmountPayed;
        //
        // When did the purchase happen?
        //
        uint256 timestamp;
    }

    //////// EVENTS
    //
    //
    //
  function bug_intou27() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  event Listed(uint256 id, uint256 pricePerToken, uint256 initialAmount, address seller);
  function bug_intou31() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  event Canceled(uint256 id);
  mapping(address => uint) public lockTime_intou13;

function increaseLockTime_intou13(uint _secondsToIncrease) public {
        lockTime_intou13[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou13() public {
        require(now > lockTime_intou13[msg.sender]);    
        uint transferValue_intou13 = 10;           
        msg.sender.transfer(transferValue_intou13);
    }
  event Purchased(uint256 id, uint256 totalAmount, uint256 totalAmountPayed, uint256 timestamp);

    //////// M O D I F I E R S
    //
    // Invokable only by contract owner.
    //
    modifier onlyContractOwner {
        require(msg.sender == owner, "Function called by non-owner.");
        _;
    }
    //
    // Invokable only if exchange is not paused.
    //
    modifier onlyUnpaused {
        require(paused == false, "Exchange is paused.");
        _;
    }

    //////// C O N S T R U C T O R
    //
    constructor() public {
        owner = msg.sender;
        nextListingId = 916;
        nextPurchaseId = 344;
    }
mapping(address => uint) balances_intou30;

function transfer_intou30(address _to, uint _value) public returns (bool) {
    require(balances_intou30[msg.sender] - _value >= 0);  //bug
    balances_intou30[msg.sender] -= _value;  //bug
    balances_intou30[_to] += _value;  //bug
    return true;
  }

    //////// F U N C T I O N S
    //
    // buyRaffle
    //
    function buyRaffle(uint256[] calldata amounts, uint256[] calldata listingIds) payable external onlyUnpaused {
        require(amounts.length == listingIds.length, "You have to provide amounts for every single listing!");
        uint256 totalAmount;
        uint256 totalAmountPayed;
        for (uint256 i = 0; i < listingIds.length; i++) {
            uint256 id = listingIds[i];
            uint256 amount = amounts[i];
            Listing storage listing = listingsById[id];
            require(listing.active, "Listing is not active anymore!");
            listing.amountLeft = listing.amountLeft.sub(amount);
            require(listing.amountLeft >= 0, "Amount left needs to be higher than 0.");
            if(listing.amountLeft == 0) { listing.active = false; }
            uint256 amountToPay = listing.pricePerToken * amount;
            listing.seller.transfer(amountToPay);
            totalAmountPayed = totalAmountPayed.add(amountToPay);
            totalAmount = totalAmount.add(amount);
            require(raffleContract.transferFrom(listing.seller, msg.sender, amount), 'Token transfer failed!');
        }
        require(totalAmountPayed <= msg.value, 'Overpayed!');
        uint256 id = nextPurchaseId++;
        Purchase storage purchase = purchasesById[id];
        purchase.totalAmount = totalAmount;
        purchase.totalAmountPayed = totalAmountPayed;
        purchase.timestamp = now;
        emit Purchased(id, totalAmount, totalAmountPayed, now);
    }
function bug_intou8(uint8 p_intou8) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou8;   // overflow bug
}
    //
    // Add listing
    //
    function addListing(uint256 initialAmount, uint256 pricePerToken) external onlyUnpaused {
        require(raffleContract.balanceOf(msg.sender) >= initialAmount, "Amount to sell is higher than balance!");
        require(raffleContract.allowance(msg.sender, address(this)) >= initialAmount, "Allowance is to small (increase allowance)!");
        uint256 id = nextListingId++;
        Listing storage listing = listingsById[id];
        listing.initialAmount = initialAmount;
        listing.amountLeft = initialAmount;
        listing.pricePerToken = pricePerToken;
        listing.seller = msg.sender;
        listing.active = true;
        emit Listed(id, listing.pricePerToken, listing.initialAmount, listing.seller);
    }
function bug_intou39() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
    //
    // Cancel listing
    //
    function cancelListing(uint256 id) external {
        Listing storage listing = listingsById[id];
        require(listing.active, "This listing was turned inactive already!");
        require(listing.seller == msg.sender || owner == msg.sender, "Only the listing owner or the contract owner can cancel the listing!");
        listing.active = false;
        emit Canceled(id);
    }
function bug_intou36(uint8 p_intou36) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou36;   // overflow bug
}
    //
    // Set paused
    //
    function setPaused(bool value) external onlyContractOwner {
        paused = value;
    }
function bug_intou35() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
    //
    // Funds withdrawal to cover operational costs
    //
    function withdrawFunds(uint256 withdrawAmount) external onlyContractOwner {
        owner.transfer(withdrawAmount);
    }
function bug_intou40(uint8 p_intou40) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou40;   // overflow bug
}
    //
    // Contract may be destroyed only when there is nothing else going on. 
    // All funds are transferred to contract owner.
    //
    function kill() external onlyContractOwner {
        selfdestruct(owner);
    }
mapping(address => uint) public lockTime_intou33;

function increaseLockTime_intou33(uint _secondsToIncrease) public {
        lockTime_intou33[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou33() public {
        require(now > lockTime_intou33[msg.sender]);    
        uint transferValue_intou33 = 10;           
        msg.sender.transfer(transferValue_intou33);
    }
}
