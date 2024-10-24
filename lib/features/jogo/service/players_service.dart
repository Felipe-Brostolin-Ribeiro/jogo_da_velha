import 'package:jogo_velha/core/database/db.dart';
import 'package:jogo_velha/features/jogo/model/player.dart';

class PlayersService {
  final Db db;

  PlayersService({required this.db});

  Future<List<Player>> getPlayers() async {
    final database = await db.database;
    final mapList = await database.query("players");
    List<Player> players = [];
    for (final map in mapList) {
      final player = Player.fromMap(map);
      players.add(player);
    }
    return players;
  }
}
