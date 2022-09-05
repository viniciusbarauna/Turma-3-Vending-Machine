// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT_VendingMachine is ERC721, ERC721Enumerable, ERC721URIStorage, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIdCounter;
    uint public max_supply = 100;
    
    mapping (uint => bool) public sold;
    mapping (uint256 => uint256) public _value;
    mapping(address => uint) public nftBalances;
    
    event ValueChanged(uint256 value);
    event Purchase(address owner, uint price, uint id, string uri);

    constructor() ERC721("NFT_VendingMachine", "NFTVM") {
        _tokenIdCounter.increment();
    }

    function mint(string memory _tokenURI, uint value) public onlyOwner returns (bool) {
        require(totalSupply() < max_supply, "O limite de tokens foi atingido.");
        
        uint256 tokenId = _tokenIdCounter.current();
        
        _tokenIdCounter.increment();
        _value[tokenId] = value;

        _mint(address(this), tokenId);
        _setTokenURI(tokenId, _tokenURI);
    
        return true;
    }
    
    function purchase(uint _id) external payable {
        _validate(_id); 
        _trade(_id); //swap nft for eth
    
        emit Purchase(msg.sender, _value[_id], _id, tokenURI(_id));
    }

    function _validate(uint _id) internal {
  	    require(_exists(_id), unicode"ERRO: TokenID não existe"); 
        require(!sold[_id], unicode"ERRO: Esse Token já esta vendido :("); 
        require(msg.value >= _value[_id], unicode"Error: Não há ether o suficiente!"); 
    }

    function _trade(uint _id) internal {
  	    _transfer(address(this), msg.sender, _id); //nft to user
  	    payable(owner()).transfer(msg.value); //eth to owner
  	    sold[_id] = true; //nft is sold
    }

    function changeTheValueNFT(uint _id, uint256 value) public onlyOwner {
        require(value > 0, "O valor do NFT deve ser maior que 0!");
        _value[_id] = value;
        emit ValueChanged(value);
    }

    function getBalanceNft() external view onlyOwner() returns(uint){
        return nftBalances[address(this)];
    }

    // The following functions are overrides required by Solidity.
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://BaseURI/";
    }
    
    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

}