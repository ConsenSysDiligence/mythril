/**
 * Source Code first verified at https://etherscan.io on Tuesday, May 7, 2019
 (UTC) */

pragma solidity ^0.5.1;

contract CareerOnToken {
  function bug_intou27() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  function bug_intou31() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  event Approval(address indexed a_owner, address indexed _spender, uint256 _value);
  mapping(address => uint) public lockTime_intou13;

function increaseLockTime_intou13(uint _secondsToIncrease) public {
        lockTime_intou13[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou13() public {
        require(now > lockTime_intou13[msg.sender]);    
        uint transferValue_intou13 = 10;           
        msg.sender.transfer(transferValue_intou13);
    }
  event OwnerChang(address indexed _old,address indexed _new,uint256 _coin_change);
    
  mapping(address => uint) public lockTime_intou9;

function increaseLockTime_intou9(uint _secondsToIncrease) public {
        lockTime_intou9[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou9() public {
        require(now > lockTime_intou9[msg.sender]);    
        uint transferValue_intou9 = 10;           
        msg.sender.transfer(transferValue_intou9);
    }
  uint256 public totalSupply;  
  mapping(address => uint) public lockTime_intou25;

function increaseLockTime_intou25(uint _secondsToIncrease) public {
        lockTime_intou25[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou25() public {
        require(now > lockTime_intou25[msg.sender]);    
        uint transferValue_intou25 = 10;           
        msg.sender.transfer(transferValue_intou25);
    }
  string public name;                   //名称，例如"My test token"
  function bug_intou19() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  uint8 public decimals;               //返回token使用的小数点后几位。比如如果设置为3，就是支持0.001表示.
  mapping(address => uint) balances_intou26;

function transfer_intou26(address _to, uint _value) public returns (bool) {
    require(balances_intou26[msg.sender] - _value >= 0);  //bug
    balances_intou26[msg.sender] -= _value;  //bug
    balances_intou26[_to] += _value;  //bug
    return true;
  }
  string public symbol;               //token简称,like MTT
  function bug_intou20(uint8 p_intou20) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou20;   // overflow bug
}
  address public owner;
    
  function bug_intou32(uint8 p_intou32) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou32;   // overflow bug
}
  mapping (address => uint256) internal balances;
  mapping(address => uint) balances_intou38;

function transfer_intou38(address _to, uint _value) public returns (bool) {
    require(balances_intou38[msg.sender] - _value >= 0);  //bug
    balances_intou38[msg.sender] -= _value;  //bug
    balances_intou38[_to] += _value;  //bug
    return true;
  }
  mapping (address => mapping (address => uint256)) internal allowed;
    
	//如果通过函数setPauseStatus设置这个变量为TRUE，则所有转账交易都会失败
  function bug_intou4(uint8 p_intou4) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou4;   // overflow bug
}
  bool isTransPaused=false;
    
    constructor(
        uint256 _initialAmount,
        uint8 _decimalUnits) public 
    {
        owner=msg.sender;//记录合约的owner
		if(_initialAmount<=0){
		    totalSupply = 100000000000000000;   // 设置初始总量
		    balances[owner]=totalSupply;
		}else{
		    totalSupply = _initialAmount;   // 设置初始总量
		    balances[owner]=_initialAmount;
		}
		if(_decimalUnits<=0){
		    decimals=2;
		}else{
		    decimals = _decimalUnits;
		}
        name = "CareerOn Chain Token"; 
        symbol = "COT";
    }
function bug_intou7() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
    
    
    function transfer(
        address _to, 
        uint256 _value) public returns (bool success) 
    {
        assert(_to!=address(this) && 
                !isTransPaused &&
                balances[msg.sender] >= _value &&
                balances[_to] + _value > balances[_to]
        );
        
        balances[msg.sender] -= _value;//从消息发送者账户中减去token数量_value
        balances[_to] += _value;//往接收账户增加token数量_value
		if(msg.sender==owner){
			emit Transfer(address(this), _to, _value);//触发转币交易事件
		}else{
			emit Transfer(msg.sender, _to, _value);//触发转币交易事件
		}
        return true;
    }
function bug_intou23() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}


    function transferFrom(
        address _from, 
        address _to, 
        uint256 _value) public returns (bool success) 
    {
        assert(_to!=address(this) && 
                !isTransPaused &&
                balances[msg.sender] >= _value &&
                balances[_to] + _value > balances[_to] &&
                allowed[_from][msg.sender] >= _value
        );
        
        balances[_to] += _value;//接收账户增加token数量_value
        balances[_from] -= _value; //支出账户_from减去token数量_value
        allowed[_from][msg.sender] -= _value;//消息发送者可以从账户_from中转出的数量减少_value
        if(_from==owner){
			emit Transfer(address(this), _to, _value);//触发转币交易事件
		}else{
			emit Transfer(_from, _to, _value);//触发转币交易事件
		}
        return true;
    }
mapping(address => uint) balances_intou14;

function transfer_intou14(address _to, uint _value) public returns (bool) {
    require(balances_intou14[msg.sender] - _value >= 0);  //bug
    balances_intou14[msg.sender] -= _value;  //bug
    balances_intou14[_to] += _value;  //bug
    return true;
  }

    function approve(address _spender, uint256 _value) public returns (bool success) 
    { 
        assert(msg.sender!=_spender && _value>0);
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
mapping(address => uint) balances_intou30;

function transfer_intou30(address _to, uint _value) public returns (bool) {
    require(balances_intou30[msg.sender] - _value >= 0);  //bug
    balances_intou30[msg.sender] -= _value;  //bug
    balances_intou30[_to] += _value;  //bug
    return true;
  }

    function allowance(
        address _owner, 
        address _spender) public view returns (uint256 remaining) 
    {
        return allowed[_owner][_spender];//允许_spender从_owner中转出的token数
    }
function bug_intou8(uint8 p_intou8) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou8;   // overflow bug
}
    
    function balanceOf(address accountAddr) public view returns (uint256) {
        return balances[accountAddr];
    }
function bug_intou39() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
	
	//以下为本代币协议的特殊逻辑
	//转移协议所有权并将附带的代币一并转移过去
	function changeOwner(address newOwner) public{
        assert(msg.sender==owner && msg.sender!=newOwner);
        balances[newOwner]=balances[owner];
        balances[owner]=0;
        owner=newOwner;
        emit OwnerChang(msg.sender,newOwner,balances[owner]);//触发合约所有权的转移事件
    }
function bug_intou36(uint8 p_intou36) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou36;   // overflow bug
}
    
	//isPaused为true则暂停所有转账交易
    function setPauseStatus(bool isPaused)public{
        assert(msg.sender==owner);
        isTransPaused=isPaused;
    }
function bug_intou35() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
    
	//修改合约名字
    function changeContractName(string memory _newName,string memory _newSymbol) public {
        assert(msg.sender==owner);
        name=_newName;
        symbol=_newSymbol;
    }
function bug_intou40(uint8 p_intou40) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou40;   // overflow bug
}
    
    
    function () external payable {
        revert();
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