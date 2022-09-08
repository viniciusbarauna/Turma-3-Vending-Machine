// SPDX-License-Identifier: GPL-3.0

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
    uint public max_supply = 100; // maximo de nft que a é possivel criar

    receive() external payable{ } // função para o contrato receber ether

    mapping (uint => bool) public sold; // retorna se um nft ja foi vendido
    mapping (uint256 => uint256) public _value;  // retornar o valor de um nft
    mapping (address => uint) public nftBalances; // retornar a qtd de nft de uma conta

    event ValueChanged(uint256 value);
    event Purchase(address owner, uint price, uint id, string uri);

    constructor() ERC721("NFT_VendingMachine", "NFTVM") {
        _tokenIdCounter.increment();
    }

    function mint(string memory _tokenURI, uint value) public onlyOwner returns(bool) {
        require(totalSupply() < max_supply, "O limite de tokens foi atingido.");
        require(value > 0, unicode"[ERRO] Valor inválido"); // require para value ser > 0

        uint256 tokenId = _tokenIdCounter.current();

        _tokenIdCounter.increment();
        _value[tokenId] = value;

        _mint(address(this), tokenId);
        _setTokenURI(tokenId, _tokenURI);

        return true;
    }

    function purchase(uint _id) external payable {
        _validate(_id);
        _trade(_id); // swap nft for eth
        nftBalances[msg.sender]++; // indica quantos nft's um endereço possui

        emit Purchase(msg.sender, _value[_id], _id, tokenURI(_id));
    }

    function _validate(uint _id) internal {
  	    require(_exists(_id), unicode"ERRO: TokenID não existe");
        require(!sold[_id], unicode"ERRO: Esse Token já esta vendido :(");
        require(msg.value >= _value[_id], unicode"Error: Não há ether o suficiente!");
    }

    function _trade(uint _id) internal {
        // inverti a ordem por segurança, dessa maneira
        // 1º envia o ether, depois envia o NFT
  	    //payable(owner()).transfer(msg.value); //eth to owner
  	    payable(address(this)).transfer(msg.value); //eth to contract
  	    _transfer(address(this), msg.sender, _id); //nft to user
  	    sold[_id] = true; //nft is sold
    }


    // talvez eu tire o modificador onlyOwner, pois assim
    // quem for dono do token pode modificar o valor dele
    function changeTheValueNFT(uint _id, uint256 value) public onlyOwner {
        require(value > 0, "O valor do NFT deve ser maior que 0!");
        _value[_id] = value;
        emit ValueChanged(value);
    }

    // vou deixar essa função pra retornar os nft
    // que não estão vendidos.
    function getBalanceNft() external view returns(uint){
        return nftBalances[address(this)];
    }

    //função para sacar X quantidade do contrato para um Owner.
    function _sacar(uint256 _amount) public payable onlyOwner {
        require(address(this).balance >= _amount, unicode"ERRO: saldo indisponível no contrato!");
        payable(owner()).transfer(_amount);
    }

    // The following functions are overrides required by Solidity.
    function _baseURI() internal pure override returns (string memory) {
        //return "ipfs://QmddxEdz2U44vdkRxdvYZmtAwjfBKrFabQPD4WhVkbgH78/";
        return "https://ipfs.io/ipfs/QmXtWaD1YH6fNshGHC7R2FDvCfF63KzoxdAhq5edvqSHbo/";
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
