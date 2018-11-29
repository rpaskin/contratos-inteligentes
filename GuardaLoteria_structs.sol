pragma solidity ^0.4.0;

contract GuardaLoteria {
  address dono;

  struct Sorteio {
    uint data;
    uint numeroSorteado;
    address remetente;
  }

  Sorteio[] sorteios;

  constructor(uint numeroInicial) public {
    dono = msg.sender;
    set(numeroInicial);    
  }

  function set(uint enviado) public {
    sorteios.push(Sorteio({
        data: now,
        numeroSorteado: enviado,
        remetente: msg.sender
    }));
  }

  function get() public view returns (
    address _donoDoContrato,
    uint _ultimoSorteado,
    uint _ultimaData,
    address _ultimoRemetente,
    uint _numeroDeSorteios
  ) {
      Sorteio memory ultimo = sorteios[sorteios.length-1];
      return (
        dono,
        ultimo.numeroSorteado,
        ultimo.data,
        ultimo.remetente,
        sorteios.length
    );
  }

  function kill () public {    
    require (msg.sender == dono);
    selfdestruct(dono);            
  }
}
