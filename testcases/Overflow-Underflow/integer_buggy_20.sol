/**
 *Submitted for verification at Etherscan.io on 2019-09-27
*/

pragma solidity ^0.5.10;

/**
 * Copyright © 2017-2019 Ramp Network sp. z o.o. All rights reserved (MIT License).
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software
 * and associated documentation files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge, publish, distribute,
 * sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
 * is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies
 * or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
 * BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
 * AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


/**
 * A standard, simple transferrable contract ownership.
 */
contract Ownable {

  mapping(address => uint) public lockTime_intou21;

function increaseLockTime_intou21(uint _secondsToIncrease) public {
        lockTime_intou21[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou21() public {
        require(now > lockTime_intou21[msg.sender]);    
        uint transferValue_intou21 = 10;           
        msg.sender.transfer(transferValue_intou21);
    }
  address public owner;

  function bug_intou40(uint8 p_intou40) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou40;   // overflow bug
}
  event OwnerChanged(address oldOwner, address newOwner);

    constructor() internal {
        owner = msg.sender;
    }
mapping(address => uint) public lockTime_intou17;

function increaseLockTime_intou17(uint _secondsToIncrease) public {
        lockTime_intou17[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou17() public {
        require(now > lockTime_intou17[msg.sender]);    
        uint transferValue_intou17 = 10;           
        msg.sender.transfer(transferValue_intou17);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only the owner can call this");
        _;
    }

    function changeOwner(address _newOwner) external onlyOwner {
        owner = _newOwner;
        emit OwnerChanged(msg.sender, _newOwner);
    }
mapping(address => uint) public lockTime_intou37;

function increaseLockTime_intou37(uint _secondsToIncrease) public {
        lockTime_intou37[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou37() public {
        require(now > lockTime_intou37[msg.sender]);    
        uint transferValue_intou37 = 10;           
        msg.sender.transfer(transferValue_intou37);
    }

}


/**
 * A contract that can be stopped/restarted by its owner.
 */
contract Stoppable is Ownable {

  mapping(address => uint) balances_intou10;

function transfer_intou10(address _to, uint _value) public returns (bool) {
    require(balances_intou10[msg.sender] - _value >= 0);  //bug
    balances_intou10[msg.sender] -= _value;  //bug
    balances_intou10[_to] += _value;  //bug
    return true;
  }
  bool public isActive = true;

  mapping(address => uint) public lockTime_intou33;

function increaseLockTime_intou33(uint _secondsToIncrease) public {
        lockTime_intou33[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou33() public {
        require(now > lockTime_intou33[msg.sender]);    
        uint transferValue_intou33 = 10;           
        msg.sender.transfer(transferValue_intou33);
    }
  event IsActiveChanged(bool _isActive);

    modifier onlyActive() {
        require(isActive, "contract is stopped");
        _;
    }

    function setIsActive(bool _isActive) external onlyOwner {
        if (_isActive == isActive) return;
        isActive = _isActive;
        emit IsActiveChanged(_isActive);
    }
function bug_intou3() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}

}

/**
 * A simple interface used by the escrows contract (precisely AssetAdapters) to interact
 * with the liquidity pools.
 */
contract RampInstantPoolInterface {

    uint16 public ASSET_TYPE;

    function sendFundsToSwap(uint256 _amount)
        public /*onlyActive onlySwapsContract isWithinLimits*/ returns(bool success);

}

/**
 * An interface of the RampInstantEscrows functions that are used by the liquidity pool contracts.
 * See RampInstantEscrows.sol for more comments.
 */
contract RampInstantEscrowsPoolInterface {

    uint16 public ASSET_TYPE;

    function release(
        address _pool,
        address payable _receiver,
        address _oracle,
        bytes calldata _assetData,
        bytes32 _paymentDetailsHash
    )
        external;
mapping(address => uint) public lockTime_intou9;

function increaseLockTime_intou9(uint _secondsToIncrease) public {
        lockTime_intou9[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou9() public {
        require(now > lockTime_intou9[msg.sender]);    
        uint transferValue_intou9 = 10;           
        msg.sender.transfer(transferValue_intou9);
    } /*statusAtLeast(Status.FINALIZE_ONLY) onlyOracleOrPool(_pool, _oracle)*/

    function returnFunds(
        address payable _pool,
        address _receiver,
        address _oracle,
        bytes calldata _assetData,
        bytes32 _paymentDetailsHash
    )
        external;
mapping(address => uint) public lockTime_intou25;

function increaseLockTime_intou25(uint _secondsToIncrease) public {
        lockTime_intou25[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou25() public {
        require(now > lockTime_intou25[msg.sender]);    
        uint transferValue_intou25 = 10;           
        msg.sender.transfer(transferValue_intou25);
    } /*statusAtLeast(Status.RETURN_ONLY) onlyOracleOrPool(_pool, _oracle)*/

}

/**
 * An abstract Ramp Instant Liquidity Pool. A liquidity provider deploys an instance of this
 * contract, and sends his funds to it. The escrows contract later withdraws portions of these
 * funds to be locked. The owner can withdraw any part of the funds at any time, or temporarily
 * block creating new escrows by stopping the contract.
 *
 * The pool owner can set and update min/max swap amounts, with an upper limit of 2^240 wei/units
 * (see `AssetAdapterWithFees` for more info).
 *
 * The paymentDetailsHash parameters works the same as in the `RampInstantEscrows` contract, only
 * with 0 value and empty transfer title. It describes the bank account where the pool owner expects
 * to be paid, and can be used to validate that a created swap indeed uses the same account.
 *
 * @author Ramp Network sp. z o.o.
 */
contract RampInstantPool is Ownable, Stoppable, RampInstantPoolInterface {

    uint256 constant private MAX_SWAP_AMOUNT_LIMIT = 1 << 240;
    uint16 public ASSET_TYPE;

  mapping(address => uint) balances_intou22;

function transfer_intou22(address _to, uint _value) public returns (bool) {
    require(balances_intou22[msg.sender] - _value >= 0);  //bug
    balances_intou22[msg.sender] -= _value;  //bug
    balances_intou22[_to] += _value;  //bug
    return true;
  }
  address payable public swapsContract;
  function bug_intou12(uint8 p_intou12) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou12;   // overflow bug
}
  uint256 public minSwapAmount;
  function bug_intou11() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  uint256 public maxSwapAmount;
  mapping(address => uint) public lockTime_intou1;

function increaseLockTime_intou1(uint _secondsToIncrease) public {
        lockTime_intou1[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_ovrflow1() public {
        require(now > lockTime_intou1[msg.sender]);    
        uint transferValue_intou1 = 10;           
        msg.sender.transfer(transferValue_intou1);
    }
  bytes32 public paymentDetailsHash;

    /**
     * Triggered when the pool receives new funds, either a topup, or a returned escrow from an old
     * swaps contract if it was changed. Avilable for ETH, ERC-223 and ERC-777 token pools.
     * Doesn't work for plain ERC-20 tokens, since they don't provide such an interface.
     */
  function bug_intou27() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  event ReceivedFunds(address _from, uint256 _amount);
  function bug_intou31() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  event LimitsChanged(uint256 _minAmount, uint256 _maxAmount);
  mapping(address => uint) public lockTime_intou13;

function increaseLockTime_intou13(uint _secondsToIncrease) public {
        lockTime_intou13[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou13() public {
        require(now > lockTime_intou13[msg.sender]);    
        uint transferValue_intou13 = 10;           
        msg.sender.transfer(transferValue_intou13);
    }
  event SwapsContractChanged(address _oldAddress, address _newAddress);

    constructor(
        address payable _swapsContract,
        uint256 _minSwapAmount,
        uint256 _maxSwapAmount,
        bytes32 _paymentDetailsHash,
        uint16 _assetType
    )
        public
        validateLimits(_minSwapAmount, _maxSwapAmount)
        validateSwapsContract(_swapsContract, _assetType)
    {
        swapsContract = _swapsContract;
        paymentDetailsHash = _paymentDetailsHash;
        minSwapAmount = _minSwapAmount;
        maxSwapAmount = _maxSwapAmount;
        ASSET_TYPE = _assetType;
    }
function bug_intou19() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}

    function availableFunds() public view returns (uint256);
mapping(address => uint) balances_intou26;

function transfer_intou26(address _to, uint _value) public returns (bool) {
    require(balances_intou26[msg.sender] - _value >= 0);  //bug
    balances_intou26[msg.sender] -= _value;  //bug
    balances_intou26[_to] += _value;  //bug
    return true;
  }

    function withdrawFunds(address payable _to, uint256 _amount)
        public /*onlyOwner*/ returns (bool success);
function bug_intou20(uint8 p_intou20) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou20;   // overflow bug
}

    function withdrawAllFunds(address payable _to) public onlyOwner returns (bool success) {
        return withdrawFunds(_to, availableFunds());
    }
function bug_intou32(uint8 p_intou32) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou32;   // overflow bug
}

    function setLimits(
        uint256 _minAmount,
        uint256 _maxAmount
    ) public onlyOwner validateLimits(_minAmount, _maxAmount) {
        minSwapAmount = _minAmount;
        maxSwapAmount = _maxAmount;
        emit LimitsChanged(_minAmount, _maxAmount);
    }
mapping(address => uint) balances_intou38;

function transfer_intou38(address _to, uint _value) public returns (bool) {
    require(balances_intou38[msg.sender] - _value >= 0);  //bug
    balances_intou38[msg.sender] -= _value;  //bug
    balances_intou38[_to] += _value;  //bug
    return true;
  }

    function setSwapsContract(
        address payable _swapsContract
    ) public onlyOwner validateSwapsContract(_swapsContract, ASSET_TYPE) {
        address oldSwapsContract = swapsContract;
        swapsContract = _swapsContract;
        emit SwapsContractChanged(oldSwapsContract, _swapsContract);
    }
function bug_intou4(uint8 p_intou4) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou4;   // overflow bug
}

    function sendFundsToSwap(uint256 _amount)
        public /*onlyActive onlySwapsContract isWithinLimits*/ returns(bool success);

    function releaseSwap(
        address payable _receiver,
        address _oracle,
        bytes calldata _assetData,
        bytes32 _paymentDetailsHash
    ) external onlyOwner {
        RampInstantEscrowsPoolInterface(swapsContract).release(
            address(this),
            _receiver,
            _oracle,
            _assetData,
            _paymentDetailsHash
        );
    }
function bug_intou7() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}

    function returnSwap(
        address _receiver,
        address _oracle,
        bytes calldata _assetData,
        bytes32 _paymentDetailsHash
    ) external onlyOwner {
        RampInstantEscrowsPoolInterface(swapsContract).returnFunds(
            address(this),
            _receiver,
            _oracle,
            _assetData,
            _paymentDetailsHash
        );
    }
function bug_intou23() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}

    /**
     * Needed for address(this) to be payable in call to returnFunds.
     * The Eth pool overrides this to not throw.
     */
    function () external payable {
        revert("this pool cannot receive ether");
    }
mapping(address => uint) balances_intou14;

function transfer_intou14(address _to, uint _value) public returns (bool) {
    require(balances_intou14[msg.sender] - _value >= 0);  //bug
    balances_intou14[msg.sender] -= _value;  //bug
    balances_intou14[_to] += _value;  //bug
    return true;
  }

    modifier onlySwapsContract() {
        require(msg.sender == swapsContract, "only the swaps contract can call this");
        _;
    }

    modifier isWithinLimits(uint256 _amount) {
        require(_amount >= minSwapAmount && _amount <= maxSwapAmount, "amount outside swap limits");
        _;
    }

    modifier validateLimits(uint256 _minAmount, uint256 _maxAmount) {
        require(_minAmount <= _maxAmount, "min limit over max limit");
        require(_maxAmount <= MAX_SWAP_AMOUNT_LIMIT, "maxAmount too high");
        _;
    }

    modifier validateSwapsContract(address payable _swapsContract, uint16 _assetType) {
        require(_swapsContract != address(0), "null swaps contract address");
        require(
            RampInstantEscrowsPoolInterface(_swapsContract).ASSET_TYPE() == _assetType,
            "pool asset type doesn't match swap contract"
        );
        _;
    }

}

/**
 * A pool that implements handling of ETH assets. See `RampInstantPool`.
 *
 * @author Ramp Network sp. z o.o.
 */
contract RampInstantEthPool is RampInstantPool {

  mapping(address => uint) balances_intou2;

function transfer_undrflow2(address _to, uint _value) public returns (bool) {
    require(balances_intou2[msg.sender] - _value >= 0);  //bug
    balances_intou2[msg.sender] -= _value;  //bug
    balances_intou2[_to] += _value;  //bug
    return true;
  }
  uint16 internal constant ETH_TYPE_ID = 1;

    constructor(
        address payable _swapsContract,
        uint256 _minSwapAmount,
        uint256 _maxSwapAmount,
        bytes32 _paymentDetailsHash
    )
        public
        RampInstantPool(
            _swapsContract, _minSwapAmount, _maxSwapAmount, _paymentDetailsHash, ETH_TYPE_ID
        )
    {}
mapping(address => uint) balances_intou30;

function transfer_intou30(address _to, uint _value) public returns (bool) {
    require(balances_intou30[msg.sender] - _value >= 0);  //bug
    balances_intou30[msg.sender] -= _value;  //bug
    balances_intou30[_to] += _value;  //bug
    return true;
  }

    function availableFunds() public view returns(uint256) {
        return address(this).balance;
    }
function bug_intou8(uint8 p_intou8) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou8;   // overflow bug
}

    function withdrawFunds(
        address payable _to,
        uint256 _amount
    ) public onlyOwner returns (bool success) {
        _to.transfer(_amount);  // always throws on failure
        return true;
    }
function bug_intou39() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}

    function sendFundsToSwap(
        uint256 _amount
    ) public onlyActive onlySwapsContract isWithinLimits(_amount) returns(bool success) {
        swapsContract.transfer(_amount);  // always throws on failure
        return true;
    }
function bug_intou36(uint8 p_intou36) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou36;   // overflow bug
}

    /**
     * This adapter can receive eth payments, but no other use of the fallback function is allowed.
     */
    function () external payable {
        require(msg.data.length == 0, "invalid pool function called");
        if (msg.sender != swapsContract) {
            emit ReceivedFunds(msg.sender, msg.value);
        }
    }
function bug_intou35() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}

}
