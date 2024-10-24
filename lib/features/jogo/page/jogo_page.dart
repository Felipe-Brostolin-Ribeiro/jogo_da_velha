import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo_velha/features/jogo/controller/JogoController.dart';

import '../model/player.dart';

class JogoPage extends StatefulWidget {
  final Player player1;
  final Player? player2;

  const JogoPage({super.key, required this.player1, this.player2});

  @override
  State<JogoPage> createState() => _JogoPageState();
}

class _JogoPageState extends State<JogoPage> {
  final controller = JogoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Expanded(
          child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    if (!controller.quadros[index].habilitado) return;

                    final equacao = controller.gerarEquacao();
                    if (await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Column(
                          children: [
                            Text("${equacao.num1} ${switch (equacao.sinal) {
                              0 => '+',
                              1 => '-',
                              2 => '*',
                              3 => '/',
                              int() => throw UnimplementedError(),
                            }} ${equacao.num2}"),
                            TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                // for below version 2 use this
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) {
                                setState(() {
                                  equacao.resposta = int.parse(value);
                                  print(equacao.resposta);
                                });
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                                controller.validarReposta(equacao),
                              );
                            },
                            child: Text("Enviar resultado"),
                          ),
                        ],
                      ),
                    )) return;

                    setState(() {
                      controller.marcarQuadro(index);
                      var ganhador = controller.verificarGanhador();
                      if (ganhador != 0) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Text("O jogador"),
                              );
                            });
                      }
                    });
                  },
                  child: Card(
                    child: Center(
                      child: Text(
                        controller.quadros[index].simbolo,
                        style: TextStyle(
                            fontSize: 64,
                            color: controller.quadros[index].color),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
