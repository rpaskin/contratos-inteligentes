pragma solidity ^0.4.0;

contract GuardaLoteria {
  uint numeroSorteado;
  address dono;
  uint contadorDeSorteios = 0;
  bool donoRico = false;


  constructor(uint numeroInicial) public {
  	require (msg.sender.balance > 99.99999999999 ether);

  	numeroSorteado = numeroInicial;
  	dono = msg.sender;
  	contadorDeSorteios = 1;

  	if (msg.sender.balance > 20 ether) {
  		donoRico = true;
  	}
  	else {
  		donoRico = false;
  	}

  	// donoRico = msg.sender.balance > 10;
  }

	event TrocoEnviado(address pagador, uint troco);

  function set(uint enviado) public payable comCustoMinimo(1000) {
    numeroSorteado = enviado;
    contadorDeSorteios++;

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

  function get() public view returns (uint) {
      return numeroSorteado;
  }
}





/* 
blockhash(uint blockNumber) returns (bytes32)
	hash do bloco blockNumber pedido
block.number (uint)
	Número do bloco atual
block.timestamp (uint) ou now(uint)
	Timestamp do bloco atual current block timestamp
Número de segundos desde 1/1/1970 (UTC)
	msg.sender (address)
Número da conta de quem chamou o contrato
	msg.value (uint)


<address>.balance (uint256):
	Saldo do endereço em Wei
<address>.transfer(uint256 amount):
	Enviar quantia de Wei para o endereço, usando 2300 de gas
	causa erro se der problema
<address>.send(uint256 amount) returns (bool):
	Enviar quantia de Wei para o endereço, usando 2300 de gas
	Retorna falso se der problema
Relacionadas a Contratos
	this (current contract’s type):
O endereço do contrato atual
	selfdestruct(address recipient):
Destrói o contrato atual e envia os fundos para o endereço definido

*/

// http://loterias.caixa.gov.br/wps/portal/loterias/landing/federal