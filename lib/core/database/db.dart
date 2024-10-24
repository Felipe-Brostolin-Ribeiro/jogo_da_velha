import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await openDb();
    return _database!;
  }

  Future<Database> openDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), "jogo_da_velha.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute("CREATE TABLE players( id integer primary key autoincrement,"
            "nome text , pontos integer)");
        db.execute("INSERT INTO players(nome,pontos) VALUES('Gustavo', 0), "
            "('Roberto', 0),"
            "('Felipe', 0),"
            "('Murilo', 0),"
            "('Eduardo', 0),"
            "('Gabriel', 0);");
      }
    );
  }
}
