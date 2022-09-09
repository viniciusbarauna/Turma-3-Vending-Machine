import React, { Component } from 'react'
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import './Footer.css';
import { SiGithub, SiLinkedin, SiHiveBlockchain } from "react-icons/si";
import Container from 'react-bootstrap/Container';
export default class Footer extends Component {
    render() {
    return (
        <Container>
        <Row>
          <Col className='col-footer'>
            <ul>
            <li className='TextLI'>Autores</li>
              <li><SiLinkedin /><a href='' target='_blanc'> Eduardo Matheus</a></li>
              <li><SiLinkedin /><a href='' target='_blanc'> Lucas Cuerci</a></li>
              <li><SiLinkedin /><a href='https://www.linkedin.com/in/veronica-bertozzi/' target='_blanc'> Veronica Bertozzi</a></li>
              <li><SiLinkedin /><a href='' target='_blanc'> Vinicius Barauna</a></li>
            </ul></Col>
          <Col className='col-footer'>
            <ul>
              <li className='TextLI'>GitHub</li>
              <li><SiGithub /><a href='https://github.com/EduardoRS78' target='_blanc'> Eduardo Matheus</a></li>
              <li><SiGithub /><a href='https://github.com/MohamedCuerci' target='_blanc'> Lucas Cuerci</a></li>
              <li><SiGithub /><a href='https://github.com/VeronicaBertozzi' target='_blanc'> Veronica Bertozzi</a></li>
              <li><SiGithub /><a href='https://github.com/viniciusbarauna' target='_blanc'> Vinicius Barauna</a></li>
            </ul>
          </Col>
        </Row>
        <Row>
          <Col>
            <p className='logo'>NFTVM <SiHiveBlockchain /></p>
          </Col>
        </Row>
      </Container>
    )
    }
}
