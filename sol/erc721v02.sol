pragma solidity ^0.4.19;
/**
 * v0.2
 */ 
contract Erc721 {
   string constant private tokenName = "fan coin";
   string constant private tokenSymbol = "fan";
   uint256 public totalTokens = 10000;
   address public defaultOwner; // the creator of the contract
   mapping(address => uint) private balances;
   mapping(uint256 => address) private tokenOwners;
   mapping(uint256 => bool) private tokenExists;
   mapping(address => mapping (address => uint256)) private allowed;
   mapping(address => mapping(uint256 => uint256)) private ownerTokens;
   
   mapping(uint256 => string) tokenLinks;
   
   /**
     * Constrctor function
     *
     * Initializes contract with initial supply tokens to the creator of the contract
     */
    function Erc721(
        uint256 totalSupply
    ) public {
        totalTokens = totalSupply;  // 
        defaultOwner = msg.sender;                // Give the creator all initial tokens
        // bad design.  written for educational purpose.  
        // for (uint256 i = 0; i < totalTokens; i++) {
        //     tokenOwners[i] = defaultOwner;
        //     tokenExists[i] = true;
        //     ownerTokens[defaultOwner][i] = 1;
        // }
    }
   
   
   function removeFromTokenList(address owner, uint256 _tokenId) private {
     for(uint256 i = 0;ownerTokens[owner][i] != _tokenId;i++){
       ownerTokens[owner][i] = 0;
     }
   }
   //
   // erc20 compatibility
   //
   function name() public constant returns (string){
       return tokenName;
   }
   function symbol() public constant returns (string) {
       return tokenSymbol;
   }
   function totalSupply() public constant returns (uint256){
       return totalTokens;
   }
   function balanceOf(address _owner) constant returns (uint){
       return balances[_owner];
   }
   
   //
   // erc721-specific.  non-erc20.
   //
   
   function ownerOf(uint256 _tokenId) constant returns (address){
       require(tokenExists[_tokenId]);
       return tokenOwners[_tokenId];
   }
   function approve(address _to, uint256 _tokenId){
       require(msg.sender == ownerOf(_tokenId));
       require(msg.sender != _to);
       allowed[msg.sender][_to] = _tokenId;
       Approval(msg.sender, _to, _tokenId);
   }
   function takeOwnership(uint256 _tokenId){
       require(tokenExists[_tokenId]);
       address oldOwner = ownerOf(_tokenId);
       address newOwner = msg.sender;
       require(newOwner != oldOwner);
       require(allowed[oldOwner][newOwner] == _tokenId);
       //balances[oldOwner] -= 1;
       tokenOwners[_tokenId] = newOwner;
       //balances[oldOwner] += 1;
       Transfer(oldOwner, newOwner, _tokenId);
   }
   function transfer(address _to, uint256 _tokenId){
       address currentOwner = msg.sender;
       address newOwner = _to;
       require(tokenExists[_tokenId]);
       require(currentOwner == ownerOf(_tokenId));
       require(currentOwner != newOwner);
       require(newOwner != address(0));
       removeFromTokenList(currentOwner, _tokenId);
       //balances[currentOwner] -= 1;
       tokenOwners[_tokenId] = newOwner;
       //balances[newOwner] += 1;
       Transfer(currentOwner, newOwner, _tokenId);
   }
   function tokenOfOwnerByIndex(address _owner, uint256 _index) constant returns (uint tokenId){
       return ownerTokens[_owner][_index];
   }
   function tokenMetadata(uint256 _tokenId) constant returns (string infoUrl){
       return tokenLinks[_tokenId];
   }
   
   //
   // event
   //
   
   event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
   event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
   
   
   //
   // other
   //
   
   /**
    * mint a token.  only defaultOwner can mint.  the owner of minted token belongs to defaultOwner 
    */
   function mint(uint256 _tokenId) {
    //   require(defaultOwner == msg.sender);
    //   require(!tokenExists[_tokenId]);
    //   tokenExists[_tokenId] = true;
    //   tokenOwners[_tokenId] = defaultOwner;
    //   ownerTokens[defaultOwner][_tokenId] = 1;
        mintForOther(_tokenId, msg.sender);
   }
   
   /**
    * mint for another address.  only defaultOwner can mint.
    * owner of newly minted token will be tokenOwner.
    */
   function mintForOther(uint256 _tokenId, address tokenOwner) {
       require(defaultOwner == msg.sender);
       require(!tokenExists[_tokenId]);
       tokenExists[_tokenId] = true;
       tokenOwners[_tokenId] = tokenOwner;
       ownerTokens[tokenOwner][_tokenId] = 1;
       balances[tokenOwner] += 1;
   }
}