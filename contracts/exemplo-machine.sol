// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

//.transfer() e .send() não é indicado para transferir ether, use call

contract primeiro {

    address payable public owner;
    uint256 valorDonut;
    mapping(address => uint) public donutBalances;  // hash com endereços e quantidade de donut q ele possui
                                                    //ex:  0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 => 0,
                                                    //     0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db => 1,
                                                    //     0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db => 0

    constructor() {
        owner = payable(msg.sender);
        donutBalances[address(this)] = 100; //TOTAL DE DONUTS
        valorDonut = 1 ether;
    }


    //FUNÇÕES VENDING MACHINE

    //retorna total de donuts na maquina
    function getVendingMachineBalance() external view returns(uint){
        return donutBalances[address(this)];
    }

    //retorna valor do donut 1000000000000000000(wei) = 1 ether
    function getValorDonut() external view returns(uint){
        return valorDonut;
    }

    //essa função recebe um valor e transforma em ether
    //ex: input 1(1 wei) output 1000000000000000000(1 ether)
    function setValorDonut(uint _price) external ApenasOwner() {
        valorDonut = _price * 10 ** 18;
    }


    //repor donuts na machina
    function restock(uint _amount) external ApenasOwner() {
        require(msg.sender == owner, unicode"Você não tem permissão!"); //apenas o dono/owner tem permissão
        require(_amount >= 1, "Quantidade invalida !"); //precisa ser maior q 1
        donutBalances[address(this)] += _amount;
    }

    //comprar donuts //PRECISO MELHORAR ESSA FUNÇÃO
    //ela transfere todo o dinheiro enviado
    function compra(uint _amount) external payable {
        require(msg.value == (_amount * valorDonut), "Saldo invalido !!!");
        require(donutBalances[address(this)] >= _amount, "Quantidade de donuts insuficiente !");
        (bool success,) = owner.call{value: msg.value}("");
        require(success, "Failed to send money");
        donutBalances[address(this)] -= _amount;
        donutBalances[msg.sender] += _amount;
    }


    //MODIFICADORES -> servem para modifica uma função
    modifier ApenasOwner(){
        require(msg.sender == owner, "Voce nao tem permissao de Dono(OWNER)");
        _; //retorna para a função onde foi chamado
    }
}
