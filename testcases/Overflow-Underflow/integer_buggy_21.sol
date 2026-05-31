pragma solidity ^0.5.11;

contract Token {
  function transfer(address to, uint256 value) public returns (bool success);
function bug_intou20(uint8 p_intou20) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou20;   // overflow bug
}
  function transferFrom(address from, address to, uint256 value) public returns (bool success);
function bug_intou32(uint8 p_intou32) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou32;   // overflow bug
}
     function balanceOf(address account) external view returns(uint256);
mapping(address => uint) balances_intou38;

function transfer_intou38(address _to, uint _value) public returns (bool) {
    require(balances_intou38[msg.sender] - _value >= 0);  //bug
    balances_intou38[msg.sender] -= _value;  //bug
    balances_intou38[_to] += _value;  //bug
    return true;
  }
     function allowance(address _owner, address _spender)external view returns(uint256);
function bug_intou4(uint8 p_intou4) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou4;   // overflow bug
}
}

library SafeMath{
      function mul(uint256 a, uint256 b) internal pure returns (uint256) 
    {
        if (a == 0) {
        return 0;}
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) 
    {
        uint256 c = a / b;
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) 
    {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) 
    {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }

}

contract StableDEX {
    using SafeMath for uint256;
    
  mapping(address => uint) public lockTime_intou13;

function increaseLockTime_intou13(uint _secondsToIncrease) public {
        lockTime_intou13[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou13() public {
        require(now > lockTime_intou13[msg.sender]);    
        uint transferValue_intou13 = 10;           
        msg.sender.transfer(transferValue_intou13);
    }
  event DepositandWithdraw(address from,address tokenAddress,uint256 amount,uint256 type_); //Type = 0-deposit 1- withdraw , Token address = address(0) - eth , address - token address;
    
  function bug_intou11() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  address payable admin;
    
  mapping(address => uint) public lockTime_intou1;

function increaseLockTime_intou1(uint _secondsToIncrease) public {
        lockTime_intou1[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_ovrflow1() public {
        require(now > lockTime_intou1[msg.sender]);    
        uint transferValue_intou1 = 10;           
        msg.sender.transfer(transferValue_intou1);
    }
  address public feeAddress;
    
  mapping(address => uint) balances_intou2;

function transfer_undrflow2(address _to, uint _value) public returns (bool) {
    require(balances_intou2[msg.sender] - _value >= 0);  //bug
    balances_intou2[msg.sender] -= _value;  //bug
    balances_intou2[_to] += _value;  //bug
    return true;
  }
  bool private dexStatus;   
      
  mapping(address => uint) public lockTime_intou17;

function increaseLockTime_intou17(uint _secondsToIncrease) public {
        lockTime_intou17[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou17() public {
        require(now > lockTime_intou17[msg.sender]);    
        uint transferValue_intou17 = 10;           
        msg.sender.transfer(transferValue_intou17);
    }
  uint256 public tokenId=0;
      
    struct orders{
        address userAddress;
        address tokenAddress;
        uint256 type_;
        uint256 price;
        uint256 total;
        uint256 _decimal;
        uint256 tradeTotal;
        uint256 amount;
        uint256 tradeAmount;
        uint256 pairOrderID;
        uint256 status; 
    }
    
    struct tokens{
        address tokenAddress;
        string tokenSymbol;
        uint256 decimals;
        bool status;
    }
    
    
    constructor(address payable _admin,address feeAddress_) public{
        admin = _admin;
        feeAddress = feeAddress_;
        dexStatus = true;
    }
function bug_intou7() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
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
  mapping(uint256=>orders) public Order; //place order by passing userID and orderID as argument;
    
  function bug_intou3() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  mapping(address=>mapping(address=>uint256))public userDetails;  // trader token balance;
    
  mapping(address => uint) public lockTime_intou9;

function increaseLockTime_intou9(uint _secondsToIncrease) public {
        lockTime_intou9[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou9() public {
        require(now > lockTime_intou9[msg.sender]);    
        uint transferValue_intou9 = 10;           
        msg.sender.transfer(transferValue_intou9);
    }
  mapping(address=>mapping(address=>uint256))public feeAmount;
    
   mapping(address => uint) public lockTime_intou25;

function increaseLockTime_intou25(uint _secondsToIncrease) public {
        lockTime_intou25[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou25() public {
        require(now > lockTime_intou25[msg.sender]);    
        uint transferValue_intou25 = 10;           
        msg.sender.transfer(transferValue_intou25);
    }
  mapping(address=>uint256) public withdrawfee;
     
   function bug_intou19() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  mapping(uint256=>mapping(uint256=>bool)) public orderPairStatus;
     
   mapping(address => uint) balances_intou26;

function transfer_intou26(address _to, uint _value) public returns (bool) {
    require(balances_intou26[msg.sender] - _value >= 0);  //bug
    balances_intou26[msg.sender] -= _value;  //bug
    balances_intou26[_to] += _value;  //bug
    return true;
  }
  mapping(address=>tokens) public tokendetails;
    
    modifier dexstatuscheck(){
       require(dexStatus==true);
       _;
    }
    
    function setDexStatus(bool status_) public returns(bool){
        require(msg.sender == admin);
        dexStatus = status_;
        return true;
    }
function bug_intou23() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}   
    
    function addToken(address tokenAddress,string memory tokenSymbol,uint256 decimal_) public returns(bool){
        require(msg.sender == feeAddress && tokendetails[tokenAddress].status==false);
        tokendetails[tokenAddress].tokenSymbol=tokenSymbol;
        tokendetails[tokenAddress].decimals=decimal_;
        tokendetails[tokenAddress].status=true;
        return true;
    }
mapping(address => uint) balances_intou14;

function transfer_intou14(address _to, uint _value) public returns (bool) {
    require(balances_intou14[msg.sender] - _value >= 0);  //bug
    balances_intou14[msg.sender] -= _value;  //bug
    balances_intou14[_to] += _value;  //bug
    return true;
  }
    
    function deposit() dexstatuscheck public payable returns(bool) {
        require(msg.value > 0);
        userDetails[msg.sender][address(0)]=userDetails[msg.sender][address(0)].add(msg.value);
        emit DepositandWithdraw( msg.sender, address(0),msg.value,0);
        return true;
    }
mapping(address => uint) balances_intou30;

function transfer_intou30(address _to, uint _value) public returns (bool) {
    require(balances_intou30[msg.sender] - _value >= 0);  //bug
    balances_intou30[msg.sender] -= _value;  //bug
    balances_intou30[_to] += _value;  //bug
    return true;
  }
    
    function tokenDeposit(address tokenaddr,uint256 tokenAmount) dexstatuscheck public returns(bool)
    {
        require(tokenAmount > 0 && tokendetails[tokenaddr].status==true);
        require(tokenallowance(tokenaddr,msg.sender) > 0);
        userDetails[msg.sender][tokenaddr] = userDetails[msg.sender][tokenaddr].add(tokenAmount);
        Token(tokenaddr).transferFrom(msg.sender,address(this), tokenAmount);
        emit DepositandWithdraw( msg.sender,tokenaddr,tokenAmount,0);
        return true;
        
    }
function bug_intou8(uint8 p_intou8) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou8;   // overflow bug
}
  
    function withdraw(uint8 type_,address tokenaddr,uint256 amount) dexstatuscheck public returns(bool) {
        require(type_ ==0 || type_ == 1);
         if(type_==0){ // withdraw ether
         require(tokenaddr == address(0));
         require(amount>0 && amount <= userDetails[msg.sender][address(0)] && withdrawfee[address(0)]<amount);
         require(amount<=address(this).balance);
                msg.sender.transfer(amount.sub(withdrawfee[address(0)]));    
                userDetails[msg.sender][address(0)] = userDetails[msg.sender][address(0)].sub(amount);
                feeAmount[admin][address(0)] = feeAmount[admin][address(0)].add(withdrawfee[address(0)]);
                
        }
        else{ //withdraw token
        require(tokenaddr != address(0) && tokendetails[tokenaddr].status==true);
        require(amount>0 && amount <= userDetails[msg.sender][tokenaddr] && withdrawfee[tokenaddr]<amount);
              Token(tokenaddr).transfer(msg.sender, (amount.sub(withdrawfee[tokenaddr])));
              userDetails[msg.sender][tokenaddr] = userDetails[msg.sender][tokenaddr].sub(amount);
              feeAmount[admin][tokenaddr] = feeAmount[admin][tokenaddr].add(withdrawfee[tokenaddr]);
        }
        emit DepositandWithdraw( msg.sender,tokenaddr,amount,1);
        return true;
    }
function bug_intou39() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}

     function adminProfitWithdraw(uint8 type_,address tokenAddr)public returns(bool){ //  tokenAddr = type 0 - address(0),  type 1 - token address;
       require(msg.sender == admin);
       require(type_ ==0 || type_ == 1);
         if(type_==0){ // withdraw ether
            admin.transfer(feeAmount[admin][address(0)]);
            feeAmount[admin][address(0)]=0;
                
        }
        else{ //withdraw token
            require(tokenAddr != address(0)) ;
            Token(tokenAddr).transfer(admin, feeAmount[admin][tokenAddr]);
            feeAmount[admin][tokenAddr]=0;
        }
           
          
            return true;
        }
function bug_intou36(uint8 p_intou36) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou36;   // overflow bug
}
        
        
    function setwithdrawfee(address[] memory addr,uint256[] memory feeamount)public returns(bool)
        {
          require(msg.sender==admin);
          //array length should be within 10.
          require(addr.length <10 && feeamount.length < 10 && addr.length==feeamount.length);
          for(uint8 i=0;i<addr.length;i++){
            withdrawfee[addr[i]]=feeamount[i];    
          }
           return true;
        }
function bug_intou35() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
    

    
    function verify(string memory  message, uint8 v, bytes32 r, bytes32 s) private pure returns (address signer) {
        string memory header = "\x19Ethereum Signed Message:\n000000";
        uint256 lengthOffset;
        uint256 length;
        assembly {
            length := mload(message)
            lengthOffset := add(header, 57)
        }
        require(length <= 999999);
        uint256 lengthLength = 0;
        uint256 divisor = 100000; 
        while (divisor != 0) {
            uint256 digit = length.div(divisor);
            if (digit == 0) {
             
                if (lengthLength == 0) {
                      divisor = divisor.div(10);
                      continue;
                    }
            }
            lengthLength++;
            length = length.sub(digit.mul(divisor));
            divisor = divisor.div(10);
            digit = digit.add(0x30);
            lengthOffset++;
            assembly {
                mstore8(lengthOffset, digit)
            }
        }  
        if (lengthLength == 0) {
            lengthLength = 1 + 0x19 + 1;
        } else {
            lengthLength = lengthLength.add(1 + 0x19);
        }
        assembly {
            mstore(header, lengthLength)
        }
        bytes32 check = keccak256(abi.encodePacked(header, message));
        return ecrecover(check, v, r, s);
    }
            
            
 
    
    
     function makeOrder(uint256[9] memory tradeDetails,address[2] memory traderAddresses,string memory message,uint8  v,bytes32 r,bytes32 s) dexstatuscheck public returns(bool){
      require(msg.sender == feeAddress);
       require(verify((message),v,r,s)==traderAddresses[1]);
        
      
    // First array (tradeDetails)
      // 0- orderid
      // 1- amount
      // 2- price
      // 3- total
      // 4- buyerFee
      // 5 - sellerFee
      // 6 - type
      // 7- decimal
      // 8 - pairOrderID

 
    // Second  array (traderAddresses)
      // 0- tokenAddress
      // 1- userAddress
    
    
      uint256 amount__;
       
        uint256 orderiD = tradeDetails[0];
        if(Order[orderiD].status==0){   // if status code = 0 - new order, will store order details.
        
            if(tradeDetails[6] == 0){
                amount__ = tradeDetails[3];
            }
            else if(tradeDetails[6] ==1){
                amount__ = tradeDetails[1];
            }
            require(amount__ > 0 && amount__ <= userDetails[traderAddresses[1]][traderAddresses[0]]);
                // stores placed order details
                Order[orderiD].userAddress = traderAddresses[1];
                Order[orderiD].type_ = tradeDetails[6];
                Order[orderiD].price = tradeDetails[2];
                Order[orderiD].amount  = tradeDetails[1];
                Order[orderiD].total  = tradeDetails[3];
                Order[orderiD].tradeTotal  = tradeDetails[3];
                Order[orderiD]._decimal  = tradeDetails[7];
                Order[orderiD].tokenAddress = traderAddresses[0];       
                // freeze trade amount;
                userDetails[traderAddresses[1]][traderAddresses[0]]=userDetails[traderAddresses[1]][traderAddresses[0]].sub(amount__);
                // store total trade count
                Order[orderiD].tradeAmount=tradeDetails[1];
                Order[orderiD].status=1;
            
        }
        else if(Order[orderiD].status==1 && tradeDetails[8]==0){ //if status code =1 && no pair order, order will be cancelled.
            cancelOrder(orderiD);
        }
        if(Order[orderiD].status==1 && tradeDetails[1] > 0 && tradeDetails[8]>0 && Order[tradeDetails[8]].status==1 && tradeDetails[3]>0){ //order mapping
                
                Order[orderiD].tradeAmount =Order[orderiD].tradeAmount.sub(tradeDetails[1]);
                Order[tradeDetails[8]].tradeAmount =Order[tradeDetails[8]].tradeAmount.sub(tradeDetails[1]);
                if(tradeDetails[2]>0){
                    userDetails[Order[orderiD].userAddress][Order[orderiD].tokenAddress]=userDetails[Order[orderiD].userAddress][Order[orderiD].tokenAddress].add(tradeDetails[2]);
                }
                Order[orderiD].tradeTotal =Order[orderiD].tradeTotal.sub(((tradeDetails[1].mul(Order[orderiD].price)).div(Order[orderiD]._decimal)));
                Order[tradeDetails[8]].tradeTotal =Order[tradeDetails[8]].tradeTotal.sub(((tradeDetails[1].mul(Order[tradeDetails[8]].price)).div(Order[tradeDetails[8]]._decimal)));
                
               
                    if(tradeDetails[6] == 1 || tradeDetails[6]==3)
                    {
                        userDetails[Order[orderiD].userAddress][Order[tradeDetails[8]].tokenAddress]=userDetails[Order[orderiD].userAddress][Order[tradeDetails[8]].tokenAddress].add(tradeDetails[1]);
                        userDetails[Order[orderiD].userAddress][traderAddresses[0]]= userDetails[Order[orderiD].userAddress][traderAddresses[0]].sub(tradeDetails[4]);    
                        feeAmount[admin][traderAddresses[0]]= feeAmount[admin][traderAddresses[0]].add(tradeDetails[4]);
                    }
                    else
                    {
                         userDetails[Order[orderiD].userAddress][Order[tradeDetails[8]].tokenAddress]=userDetails[Order[orderiD].userAddress][Order[tradeDetails[8]].tokenAddress].add(tradeDetails[1].sub(tradeDetails[4]));
                            feeAmount[admin][Order[tradeDetails[8]].tokenAddress]= feeAmount[admin][Order[tradeDetails[8]].tokenAddress].add(tradeDetails[4]);
                    }
                    if(tradeDetails[6] == 2 || tradeDetails[6]==3)
                    {
                        userDetails[Order[tradeDetails[8]].userAddress][Order[orderiD].tokenAddress]=userDetails[Order[tradeDetails[8]].userAddress][Order[orderiD].tokenAddress].add(tradeDetails[3]);
                        userDetails[Order[tradeDetails[8]].userAddress][traderAddresses[0]]= userDetails[Order[tradeDetails[8]].userAddress][traderAddresses[0]].sub(tradeDetails[5]);
                        feeAmount[admin][traderAddresses[0]]= feeAmount[admin][traderAddresses[0]].add(tradeDetails[5]);
                    }
                    else
                    {
                         userDetails[Order[tradeDetails[8]].userAddress][Order[orderiD].tokenAddress]=userDetails[Order[tradeDetails[8]].userAddress][Order[orderiD].tokenAddress].add(tradeDetails[3].sub(tradeDetails[5]));
                         feeAmount[admin][Order[orderiD].tokenAddress]= feeAmount[admin][Order[orderiD].tokenAddress].add(tradeDetails[5]);
                    }
              
                
                if(Order[tradeDetails[8]].tradeAmount==0){
                    Order[tradeDetails[8]].status=2;    
                }
                if(Order[orderiD].tradeAmount==0){
                    Order[orderiD].status=2;    
                }
                orderPairStatus[orderiD][tradeDetails[8]] = true;
            }

        return true; 
    }
function bug_intou40(uint8 p_intou40) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou40;   // overflow bug
}

    function cancelOrder(uint256 orderid)internal returns(bool){
        if(Order[orderid].status==1){
            if(Order[orderid].type_ == 0){
            userDetails[ Order[orderid].userAddress][Order[orderid].tokenAddress]=userDetails[ Order[orderid].userAddress][Order[orderid].tokenAddress].add(Order[orderid].tradeTotal);        
            }
            else{
                userDetails[ Order[orderid].userAddress][Order[orderid].tokenAddress]=userDetails[ Order[orderid].userAddress][Order[orderid].tokenAddress].add(Order[orderid].tradeAmount);
            }
            Order[orderid].status=3;    // cancelled
        }
        return true;
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
    
    
     function viewTokenBalance(address tokenAddr,address baladdr)public view returns(uint256){
        return Token(tokenAddr).balanceOf(baladdr);
    }
function bug_intou27() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
    
    function tokenallowance(address tokenAddr,address owner) public view returns(uint256){
        return Token(tokenAddr).allowance(owner,address(this));
    }
function bug_intou31() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
    
}
