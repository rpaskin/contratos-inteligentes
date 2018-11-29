pragma solidity ^0.4.0;

contract GuardaLoteria {
  address dono;
  uint numeroSorteado;
  uint contadorDeSorteios = 0;

  uint[] numerosSorteados;

  constructor(uint numeroInicial) public payable comCustoMinimo(1000) {
    require (msg.sender.balance > 99.99999999999 ether);

    dono = msg.sender;
    set(numeroInicial);    
  }

  event TrocoEnviado(address pagador, uint troco);

  function set(uint enviado) public payable comCustoMinimo(1000) {
    numeroSorteado = enviado;
    contadorDeSorteios++;
    numerosSorteados.push(enviado);

    if (msg.value > 1000){
      uint troco = msg.value - 1000;
      msg.sender.transfer(troco);       
      emit TrocoEnviado(msg.sender, troco);
    }
  }

  modifier comCustoMinimo(uint min) {
    require(msg.value >= min, "Nao foi enviado Ether suficiente.");
    _;
  }

  function get() public view returns (
    address _donoDoContrato,
    uint _ultimoNumeroSorteado,
    uint _contadorDeSorteios,
    uint _saldoEmWei,
    uint[] _todosNumerosSorteados
  ) {
      uint ultimo = numerosSorteados[contadorDeSorteios-1];
      return (dono, ultimo, contadorDeSorteios, address(this).balance, numerosSorteados);
  }

  function kill () public {    
    require (msg.sender == dono);
    selfdestruct(dono);            
  }
}
