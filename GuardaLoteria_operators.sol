pragma solidity ^0.4.0;

contract GuardaLoteria {
  uint16 numeroSorteado;       // 0 a 65535 

  uint contadorDeSorteios;     // 0 a  2^256 -1 ou (1.1579208923731619542357098500869e+77 – 1)

  constructor(uint16 numeroInicial) public {
    numeroSorteado = numeroInicial;
    contadorDeSorteios = 1;
  }

  function set(uint16 enviado) public {
    numeroSorteado = enviado;

    require (contadorDeSorteios + 1 > contadorDeSorteios);

    contadorDeSorteios++;
  }

  function get() public view returns (uint) {
      return numeroSorteado;
  }
}
