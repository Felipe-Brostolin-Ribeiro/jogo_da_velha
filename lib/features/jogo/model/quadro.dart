import 'package:flutter/material.dart';

class Quadro {
  final int id;
  String simbolo;
  Color color;
  bool habilitado;

  Quadro(this.id, {
    this.color = Colors.black,
    this.simbolo = '',
    this.habilitado = true,
  });
}