import React, { Component } from 'react'
import community from '../images/Comunidade1.jpg';
import Button from 'react-bootstrap/Button';
import { SiDiscord } from "react-icons/si";
import './Comunidade.css';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';


export default class Comunidade extends Component {
    render() {
        return (
            <div className='container-comunidade'>                 
                <Row>
                    <Col sm={6}><img className='img-comunidade' src={community} alt=''></img></Col>
                    <Col sm={6}><h2 className='txt-comunidade'>Entre na nossa comunidade! 😀</h2>
                    <p className='txt-comunidade'>
                        Entre na <span className='bold'>maior</span> comunidade de RPG do Brasil.<br/>
                        Nela você pode utilizar seus personagens e poções, temos vários tipos de batalhas e premiações.<br/>
                        Se animou? Então entre nessa batalha com a gente!
                    </p>
                    <p className='txt-comunidade botao'>
                        <Button variant='flat'><a className='discord' href='https://discord.com/' target='_blanc' variant='flat'><SiDiscord /> Comunidade Discord</a></Button>
                    </p>
                    
                    </Col>
                </Row>
            </div>   
        )
    }
}


/*import React, { Component } from 'react'
import community from '../images/Comunidade1.jpg';
import Button from 'react-bootstrap/Button';
import { SiDiscord } from "react-icons/si";
import './Comunidade.css';

export default class Comunidade extends Component {
    render() {
        return (
            <div className='container-comunidade'>                    
                <div className='div-img-comunidade'>
                    <img src={community} alt=''></img>
                </div>
                <div className='div-text-comunidade'>
                    <h1>Entre na nossa comunidade! 😀</h1>
                    <h2>
                        Entre na maior comunidade de RPG do Brasil. Nela você pode utilizar seus personagens e poções, temos vários tipos de batalhas e premiações.
                        <br/>
                        Se animou? Então entre nessa batalha com a gente!
                    </h2>
                    <Button variant='flat'><a className='discord' href='https://discord.com/' target='_blanc' variant='flat'><SiDiscord /> Comunidade Discord</a></Button>
                </div>
            </div>
        )
    }
}
*/