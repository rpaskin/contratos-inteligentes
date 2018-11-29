pragma solidity ^0.4.0;

contract GuardaLoteria {
  int8 numero;       // -128 a +127 
  bool numeroPar;
  bool numeroImpar;

  constructor(int256 _numero) public payable {
    set(_numero);
  }

  function set(int256 _numero) public {
    require (_numero == int8(_numero), "Valor nao cabe na variavel global");
    numero = int8(_numero);

    numeroPar = numero % 2 == 0;
    numeroImpar = !numeroPar;
  }

  function get() public view returns (int8 _numero, bool _ePar, bool _eImpar) {
      return (numero, numeroPar, numeroImpar);
  }
}
