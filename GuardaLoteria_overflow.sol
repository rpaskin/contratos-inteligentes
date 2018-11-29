pragma solidity ^0.4.0;

contract GuardaLoteria {
  uint16 numeroSorteado;       // 0 a 65535 
  uint numeroSorteadoGrande;   // 0 a  2^256 -1 ou (1.1579208923731619542357098500869e+77 – 1)

  uint16 contadorDeSorteios;

  address dono;

  constructor(uint16 numeroInicial) public {
  	numeroSorteado = numeroInicial;
  	contadorDeSorteios = 65530;
  	dono = msg.sender;
  }

  function set(uint enviado) public payable {
    numeroSorteadoGrande = enviado;
    numeroSorteado = uint16(enviado);

    require (msg.sender == dono, "apenas o dono do contrato pode setar");

    require (contadorDeSorteios + 1 > contadorDeSorteios, "overflow no contador");
    require (numeroSorteado == numeroSorteadoGrande, "overflow no numero");

    contadorDeSorteios++;
  }

  function get() public view returns (uint _numero, uint _numeroSorteadoGrande, uint16 _contador, address _dono, address _contrato, uint _saldo) {
      return (numeroSorteado,
              numeroSorteadoGrande,
              contadorDeSorteios,
              dono,
              this,
              address(this).balance);
  }
}
