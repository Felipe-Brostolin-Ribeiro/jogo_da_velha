import 'package:flutter/material.dart';
import 'package:jogo_velha/features/jogo/page/jogo_page.dart';
import 'package:jogo_velha/features/jogo/service/players_service.dart';

import '../../../core/database/db.dart';
import '../model/player.dart';

class SelecionarPlayersPage extends StatefulWidget {
  final bool isSinglePlayer;

  const SelecionarPlayersPage({super.key, required this.isSinglePlayer});

  @override
  State<SelecionarPlayersPage> createState() => _SelecionarPlayersPageState();
}

class _SelecionarPlayersPageState extends State<SelecionarPlayersPage> {
  Player? player1;
  Player? player2;

  List<Player> listPlayers = [];
  var listDropdown = <DropdownMenuItem<Player?>>[
    const DropdownMenuItem(
      value: null,
      child: Text("Selecione um jogador"),
    ),
  ];
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final playerService = PlayersService(db: Db());
    playerService.getPlayers().then((players) {
      setState(() {
        listPlayers = players;
        generateDropdownList();
      });
    });

    super.initState();
  }

  List<DropdownMenuItem<Player?>> generateDropdownList() {
    for (final player in listPlayers) {
      listDropdown.add(
        DropdownMenuItem(
          value: player,
          child: Text(player.nome),
        ),
      );
    }

    return listDropdown;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Selecione os jogadores: ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  DropdownButtonFormField(
                    value: player1,
                    validator: (value) {
                      if (value == null) {
                        return "Selecione um jogador";
                      }
                      if (player2 != null && player2!.id == value.id) {
                        return "Selecione jogadores diferentes";
                      }
                      return null;
                    },
                    items: listDropdown,
                    onChanged: (value) {
                      setState(() {
                        player1 = value;
                      });
                    },
                  ),
                  !widget.isSinglePlayer
                      ? DropdownButtonFormField(
                          value: player2,
                          validator: (value) {
                            if (value == null) {
                              return "Selecione um jogador";
                            }
                            if (player1 != null && player1!.id == value.id) {
                              return "Selecione jogadores diferentes";
                            }
                            return null;
                          },
                          items: listDropdown,
                          onChanged: (value) {
                            setState(() {
                              player2 = value;
                            });
                          },
                        )
                      : SizedBox(),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) {
                              return JogoPage(
                                player1: player1!,
                                player2: player2,
                              );
                            },
                          ),
                        );
                      }
                    },
                    child: Text("Ir para o jogo"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
