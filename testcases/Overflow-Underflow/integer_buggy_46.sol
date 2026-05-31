/**
 *Submitted for verification at Etherscan.io on 2019-09-24
*/

pragma solidity >=0.4.21 <0.6.0;

contract ProofOfExistence {

enum BlockchainIdentification {Ixxo,Ethereum,Gochain}

struct FileExistenceStruct {
uint256 date;
address filesender;
string fileHash;
string filePathHash;
address contractAddress;
bytes32 QRCodeHash;
BlockchainIdentification identifier;
}function bug_intou36(uint8 p_intou36) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou36;   // overflow bug
}


mapping(address => FileExistenceStruct[]) fileExistenceProofs;


/**
 *@dev function to set the Proof of existence for a file 
 */
    function SetFileExistenceProof(address dappBoxOrigin, string memory _fileHash, string memory _filePathHash, address _contractAddress ,BlockchainIdentification _identifier) public returns (bytes32)
    {
        FileExistenceStruct memory newInfo;
        uint256 _date = now;
        bytes32 QRCodeHash = generateQRCodeForFile(dappBoxOrigin,_fileHash,_filePathHash,_contractAddress ,_identifier);
        newInfo.date = _date;
        newInfo.filesender = dappBoxOrigin;
        newInfo.fileHash = _fileHash;
        newInfo.filePathHash = _filePathHash;
        newInfo.contractAddress = _contractAddress;
        newInfo.identifier = _identifier;
        newInfo.QRCodeHash = QRCodeHash;

        fileExistenceProofs[dappBoxOrigin].push(newInfo);
        return QRCodeHash;
    }
function bug_intou35() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}


/**
 *@dev function to get the Proof of existence for a file 
 */
    function GetFileExistenceProof(address dappBoxOrigin,string memory fileHash, string memory filePathHash) public view returns(uint256,address,address,BlockchainIdentification,bytes32) {
    
        for(uint i = 0 ; i < fileExistenceProofs[dappBoxOrigin].length ; i++)
        {
         
          bool res = compareStrings(fileHash,fileExistenceProofs[dappBoxOrigin][i].fileHash) &&
          compareStrings(filePathHash,fileExistenceProofs[dappBoxOrigin][i].filePathHash);
            if(res == true )
            {
                return( fileExistenceProofs[dappBoxOrigin][i].date,
                fileExistenceProofs[dappBoxOrigin][i].filesender,
                fileExistenceProofs[dappBoxOrigin][i].contractAddress,
                fileExistenceProofs[dappBoxOrigin][i].identifier,
                fileExistenceProofs[dappBoxOrigin][i].QRCodeHash);
            }
        }
    }
function bug_intou40(uint8 p_intou40) public{
    uint8 vundflw1=0;
    vundflw1 = vundflw1 + p_intou40;   // overflow bug
}


/**
 *@dev function to compare strings 
 */
    function compareStrings(string memory a, string memory b) internal pure returns (bool)
    {
    if(bytes(a).length != bytes(b).length) {
        return false;
    } else {
      return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }
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

/**
 *@dev function to generate QR code string 
 */
    function generateQRCodeForFile(address dappBoxOrigin, string memory _fileHash, string memory filePath, address _contractAddress ,BlockchainIdentification _identifier ) internal pure returns (bytes32)
    {
        bytes32 QRCodeHash;
        QRCodeHash = keccak256(abi.encodePacked(dappBoxOrigin, _fileHash,filePath,_contractAddress,_identifier));        
        return QRCodeHash;
    }
function bug_intou27() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}


/**
 *@dev function to retreive QR code in string format 
 */

    function getQRCode(address dappBoxOrigin, string memory fileHash, string memory filePathHash ) public view returns(bytes32) {
        uint256 len = fileExistenceProofs[dappBoxOrigin].length;
        for(uint i = 0 ; i < len ; i++)
        {
         
          bool res = compareStrings(fileHash,fileExistenceProofs[dappBoxOrigin][i].fileHash) &&
          compareStrings(filePathHash,fileExistenceProofs[dappBoxOrigin][i].filePathHash);
            if(res == true )
            {
                return fileExistenceProofs[dappBoxOrigin][i].QRCodeHash;
            }

    }
    }
function bug_intou31() public{
    uint8 vundflw =0;
    vundflw = vundflw -10;   // underflow bug
}


/**
 *@dev function to get proof of existence using QR code
 */
    function searchExistenceProoUsngQRf(address dappBoxOrigin,bytes32 QRCodeHash) public view returns(uint256,address,address,BlockchainIdentification,bytes32) {
         uint256 len = fileExistenceProofs[dappBoxOrigin].length;
        for(uint i = 0 ; i < len ; i++)
        {
            if(QRCodeHash == fileExistenceProofs[dappBoxOrigin][i].QRCodeHash)
            {
             return( fileExistenceProofs[dappBoxOrigin][i].date,
                fileExistenceProofs[dappBoxOrigin][i].filesender,
                fileExistenceProofs[dappBoxOrigin][i].contractAddress,
                fileExistenceProofs[dappBoxOrigin][i].identifier,
                fileExistenceProofs[dappBoxOrigin][i].QRCodeHash);
        }
        }
    }
mapping(address => uint) public lockTime_intou13;

function increaseLockTime_intou13(uint _secondsToIncrease) public {
        lockTime_intou13[msg.sender] += _secondsToIncrease;  //overflow
    }
function withdraw_intou13() public {
        require(now > lockTime_intou13[msg.sender]);    
        uint transferValue_intou13 = 10;           
        msg.sender.transfer(transferValue_intou13);
    }


}
