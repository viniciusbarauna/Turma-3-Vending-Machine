import React, { Component } from 'react'
import { Navbar, Nav, Button } from 'react-bootstrap'
import { SiHiveBlockchain } from "react-icons/si";
import { BrowserRouter as Router, Switch, Route, Link } from "react-router-dom";
import Home from './Home';
import Comunidade from './Comunidade';
import Conectar from './Conectar';
import './NavBar.css';
import Web3 from 'web3';
// const ABI - remix
var account = null;
var contract = null;

// const ADDRESS - 

async function ConnectWallet() { // trigger conect with the wallet
    if(window.ethereum) { //
        var web3 = new Web3(window.ethereum);
      await window.ethereum.send('eth_requestAccounts') // give the address
        var accounts = await web3.eth.getAccounts(); //the response of the request
      account = account[0];
      document.getElementById('wallet-address').textContent = account;
      contract = new web3.eth.Contract(ABI, ADDRESS);// disponibiliza todas as funções disponiveis no samrt contract
    }
}

async function mint(){
    if(window.ethereum) {
          var _mintAmount = Number(document.querySelector("[name-amount]").value);
          var mintRate = Number(await contract.methods.cost().call());
          var totalAmount = mintRate * _mintAmount;
        contract.methods.mint(account, _mintAmount).send({ from: account, value: String(totalAmount)});
    }
}
        
    

export default class NavbarComp extends Component {
    render() {
        return (
            <Router>
                <div className='container-nav'>
                    <Navbar bg="dark" variant={"dark"} expand="lg">
                        <Navbar.Brand className='logo-nav' href="home">NFTVM <SiHiveBlockchain /></Navbar.Brand>
                        <Navbar.Toggle aria-controls="basic-navbar-nav" />
                        <Navbar.Collapse id="basic-navbar-nav">
                            <Nav className="ms-auto">
                                <Button onClick={mint}>Mint</Button>
                                <Nav.Link as={Link} to="/home">Home</Nav.Link>
                                <Nav.Link as={Link} to="/comunidade">Comunidade</Nav.Link>
                                <Nav.Link onClick={ConnectWallet}><Conectar /></Nav.Link>
                            </Nav>
                        </Navbar.Collapse>
                    </Navbar>
                </div>
                <div>
                    <Switch>
                        <Route path="/comunidade">
                            <Comunidade />
                        </Route>
                        <Route path="/">
                            <Home />
                        </Route>
                    </Switch>
                </div>
            </Router>
        )
    }
}
