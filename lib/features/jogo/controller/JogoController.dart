import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jogo_velha/features/jogo/model/equacao.dart';
import 'package:jogo_velha/features/jogo/model/quadro.dart';

class JogoController {
  static const regrasVencedor = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7],
  ];

  List<Quadro> quadros = [];
  List<int> quadrosMarcados1 = [];
  List<int> quadrosMarcados2 = [];
  bool isPlayer1 = true;
  bool isSinglePlayer = false;
  int? resposta;

  void _init() {
    quadrosMarcados1.clear();
    quadrosMarcados2.clear();
    isPlayer1 = true;
    isSinglePlayer = false;
    quadros = List<Quadro>.generate(9, (index) => Quadro(index + 1));
  }

  JogoController() {
    _init();
  }

  Equacao gerarEquacao() {
    return Equacao(
        num1: Random().nextInt(100),
        num2: Random().nextInt(100),
        sinal: 0);
  }

  bool validarReposta(Equacao equacao) {
    final resposta = equacao.num1 + equacao.num2;
    return equacao.resposta != resposta;
  }

  void passarAVez() {
    isPlayer1 != isPlayer1;
  }

  bool verificarVencedorPorMovimentos(List<int> movimentos) {
    print(movimentos);
    return regrasVencedor.any(
      (regras) =>
          movimentos.contains(regras[0]) &&
          movimentos.contains(regras[1]) &&
          movimentos.contains(regras[2]),
    );
  }

  int verificarGanhador() {
    if (verificarVencedorPorMovimentos(quadrosMarcados1)) return 1;
    if (verificarVencedorPorMovimentos(quadrosMarcados2)) return 2;
    return 0;
  }

  void marcarQuadro(int index) {
    final quadro = quadros[index];
    if (isPlayer1) {
      quadro.simbolo = 'X';
      quadro.color = Colors.red;
      quadrosMarcados1.add(quadro.id);
      isPlayer1 = false;
    } else {
      quadro.simbolo = 'O';
      quadro.color = Colors.blue;
      quadrosMarcados2.add(quadro.id);
      isPlayer1 = true;
    }
    quadro.habilitado = false;
  }
}
