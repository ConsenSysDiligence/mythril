/**
 * Source Code first verified at https://etherscan.io on Friday, April 26, 2019
 (UTC) */

pragma solidity >=0.4.21 < 0.6.0;

contract DocumentSigner {
  function bug_intou39() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  mapping(bytes32=>string) public docs;
  function bug_intou36(uint8 p_intou36) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou36;   // overflow bug
}
  mapping(bytes32=>address[]) public signers;
    
    modifier validDoc(bytes32 _docHash) {
        require(bytes(docs[_docHash]).length != 0, "Document is not submitted");
        _;
    }

  function bug_intou31() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
  event Sign(bytes32 indexed _doc, address indexed _signer);
  mapping(address => uint) public lockTime_intou13;

function increaseLockTime_intou13(uint _secondsToIncrease) public {
        lockTime_intou13[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou13() public {
        require(now > lockTime_intou13[msg.sender]);    
        uint transferValue_intou13 = 10;           
        msg.sender.transfer(transferValue_intou13);
    }
  event NewDocument(bytes32 _docHash);

    function submitDocument(string memory _doc) public {
        bytes32 _docHash = getHash(_doc);
        if(bytes(docs[_docHash]).length == 0) {
            docs[_docHash] = _doc;
            emit NewDocument(_docHash);
        }
    }
function bug_intou35() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}

    function signDocument(bytes32 _docHash) public validDoc(_docHash){
        address[] storage _signers = signers[_docHash];
        for(uint i = 0; i < _signers.length; i++) {
            if(_signers[i] == msg.sender) return;
        }
        _signers.push(msg.sender);
    }
function bug_intou40(uint8 p_intou40) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou40;   // overflow bug
}
    
    function getDetail(bytes32 _docHash) public validDoc(_docHash) view returns(string memory _doc, address[] memory _signers) {
        _doc = docs[_docHash];
        _signers = signers[_docHash];
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
    
    function getHash(string memory _doc) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(_doc));
    }
function bug_intou27() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}
}