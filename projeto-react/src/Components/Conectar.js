import React, { useState } from 'react';
import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import wallet from '../images/Conect1.jpeg';

function Conectar() {
  const [show, setShow] = useState(false);

  const handleClose = () => setShow(false);
  const handleShow = () => setShow(true);

  return (
    <>
      
      <a variant="primary" onClick={handleShow}>Conectar</a>

      <Modal show={show} onHide={handleClose} backdrop="static" keyboard={false}>
        <Modal.Header closeButton>
          <Modal.Title>Conectar carteira</Modal.Title>
        </Modal.Header>
        <img src={wallet} alt=''></img>
        <Modal.Body>
            Que bom te ver aqui!<br />
            Para realizar sua compra conecte sua carteira.
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={handleClose}>
            Fechar
          </Button>
          <Button variant="primary">Conectar carteira</Button>
        </Modal.Footer>
      </Modal>
    </>
  );
}

export default Conectar;