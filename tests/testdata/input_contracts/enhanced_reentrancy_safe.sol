// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Safe Reentrancy Patterns Test Contracts
 * @dev Collection of contracts with proper reentrancy protection
 * for testing false positive reduction in Enhanced Reentrancy Detector
 */

// 1. Checks-Effects-Interactions (CEI) pattern
contract SafeCEIPattern {
    mapping(address => uint256) public balances;
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint256 amount) public {
        // CHECKS
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        // EFFECTS (state changes before external call)
        balances[msg.sender] -= amount;
        
        // INTERACTIONS (external call last)
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }
    
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}

// 2. Reentrancy guard pattern
contract SafeReentrancyGuard {
    mapping(address => uint256) public balances;
    bool private locked = false;
    
    modifier nonReentrant() {
        require(!locked, "Reentrant call");
        locked = true;
        _;
        locked = false;
    }
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint256 amount) public nonReentrant {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] -= amount;
        
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }
}

// 3. Pull payment pattern (withdraw pattern)
contract SafePullPayment {
    mapping(address => uint256) public payments;
    
    function deposit(address payee) public payable {
        payments[payee] += msg.value;
    }
    
    // Safe: Users pull their own payments
    function withdraw() public {
        uint256 payment = payments[msg.sender];
        require(payment > 0, "No payment available");
        
        payments[msg.sender] = 0; // Clear payment before transfer
        
        (bool success, ) = msg.sender.call{value: payment}("");
        require(success, "Transfer failed");
    }
    
    function pendingPayment(address payee) public view returns (uint256) {
        return payments[payee];
    }
}

// 4. Safe use of transfer() with 2300 gas limit
contract SafeTransferPattern {
    mapping(address => uint256) public balances;
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] -= amount;
        
        // Safe: transfer() only forwards 2300 gas, preventing reentrancy
        payable(msg.sender).transfer(amount);
    }
}

// 5. Safe STATICCALL usage (read-only operations)
contract SafeStaticCall {
    mapping(address => uint256) public balances;
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function checkExternalBalance(address target) public view returns (uint256) {
        // Safe: STATICCALL cannot modify state
        (bool success, bytes memory data) = target.staticcall(
            abi.encodeWithSignature("balances(address)", msg.sender)
        );
        
        if (success && data.length >= 32) {
            return abi.decode(data, (uint256));
        }
        return 0;
    }
    
    function safeWithdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}

// 6. Safe mutex with proper state management
contract SafeMutexPattern {
    mapping(address => uint256) public balances;
    mapping(address => bool) private withdrawing;
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint256 amount) public {
        require(!withdrawing[msg.sender], "Already withdrawing");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        withdrawing[msg.sender] = true;
        balances[msg.sender] -= amount;
        
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        
        withdrawing[msg.sender] = false;
    }
}

// 7. Safe commit-reveal pattern
contract SafeCommitReveal {
    struct Commitment {
        bytes32 commitment;
        uint256 amount;
        uint256 timestamp;
        bool revealed;
    }
    
    mapping(address => Commitment) public commitments;
    mapping(address => uint256) public balances;
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function commitWithdraw(bytes32 commitment, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        commitments[msg.sender] = Commitment({
            commitment: commitment,
            amount: amount,
            timestamp: block.timestamp,
            revealed: false
        });
        
        // Lock the amount
        balances[msg.sender] -= amount;
    }
    
    function revealWithdraw(uint256 nonce) public {
        Commitment storage c = commitments[msg.sender];
        require(!c.revealed, "Already revealed");
        require(block.timestamp > c.timestamp + 1 hours, "Too early");
        
        bytes32 hash = keccak256(abi.encodePacked(msg.sender, c.amount, nonce));
        require(hash == c.commitment, "Invalid reveal");
        
        c.revealed = true;
        
        // Safe: State already modified in commit phase
        (bool success, ) = msg.sender.call{value: c.amount}("");
        require(success, "Transfer failed");
    }
}

// 8. Safe factory pattern with CREATE2
contract SafeFactoryPattern {
    mapping(address => uint256) public deposits;
    mapping(bytes32 => address) public deployedContracts;
    
    function deposit() public payable {
        deposits[msg.sender] += msg.value;
    }
    
    function deployContract(bytes memory bytecode, uint256 salt) public returns (address) {
        require(deposits[msg.sender] > 0, "No deposit");
        
        bytes32 deployHash = keccak256(abi.encodePacked(bytecode, salt, msg.sender));
        require(deployedContracts[deployHash] == address(0), "Already deployed");
        
        // Safe: State changes before CREATE2
        deposits[msg.sender] = 0;
        
        address deployed;
        assembly {
            deployed := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
        }
        
        require(deployed != address(0), "Deployment failed");
        deployedContracts[deployHash] = deployed;
        
        return deployed;
    }
}

// 9. Safe delegatecall to trusted implementation
contract SafeDelegatecallPattern {
    mapping(address => uint256) public balances;
    address public immutable trustedImplementation;
    
    constructor(address _trustedImplementation) {
        trustedImplementation = _trustedImplementation;
    }
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function safeExecute(bytes calldata data) public returns (bytes memory) {
        require(balances[msg.sender] > 0, "No balance");
        
        // Safe: Effects before delegatecall to trusted implementation
        balances[msg.sender] = 0;
        
        (bool success, bytes memory result) = trustedImplementation.delegatecall(data);
        require(success, "Delegatecall failed");
        
        return result;
    }
}

// 10. Safe multi-signature pattern
contract SafeMultiSigPattern {
    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        bool executed;
        mapping(address => bool) confirmations;
        uint256 confirmationCount;
    }
    
    address[] public owners;
    mapping(address => bool) public isOwner;
    uint256 public required;
    uint256 public transactionCount;
    mapping(uint256 => Transaction) public transactions;
    
    constructor(address[] memory _owners, uint256 _required) {
        require(_owners.length > 0, "No owners");
        require(_required > 0 && _required <= _owners.length, "Invalid required");
        
        for (uint256 i = 0; i < _owners.length; i++) {
            isOwner[_owners[i]] = true;
        }
        owners = _owners;
        required = _required;
    }
    
    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not owner");
        _;
    }
    
    function submitTransaction(address to, uint256 value, bytes memory data) 
        public 
        onlyOwner 
        returns (uint256) 
    {
        uint256 txId = transactionCount++;
        Transaction storage txn = transactions[txId];
        txn.to = to;
        txn.value = value;
        txn.data = data;
        
        return txId;
    }
    
    function confirmTransaction(uint256 txId) public onlyOwner {
        Transaction storage txn = transactions[txId];
        require(!txn.executed, "Already executed");
        require(!txn.confirmations[msg.sender], "Already confirmed");
        
        txn.confirmations[msg.sender] = true;
        txn.confirmationCount++;
    }
    
    function executeTransaction(uint256 txId) public onlyOwner {
        Transaction storage txn = transactions[txId];
        require(!txn.executed, "Already executed");
        require(txn.confirmationCount >= required, "Not enough confirmations");
        
        // Safe: Proper checks and state management before external call
        txn.executed = true;
        
        (bool success, ) = txn.to.call{value: txn.value}(txn.data);
        require(success, "Transaction failed");
    }
    
    receive() external payable {}
}