import 'package:kilo_bamya/local_db/game_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GamesDatabase {
  static final GamesDatabase instance = GamesDatabase._init();

  GamesDatabase._init();

  Database? _database;

  Future<Database> getDb() async {
    _database ??= await _initDatabase('games.db');
    return _database!;
  }

  _initDatabase(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    await db.execute('''
    CREATE TABLE ${GameTable.tableName} (
      ${GameTable.id} $idType,
      ${GameTable.roomName} $textType,
      ${GameTable.noOfPlayers} $intType,
      ${GameTable.noOfTeams} $intType,
      ${GameTable.players} $textType,
      ${GameTable.result} $textType,
      ${GameTable.time} $textType,
    )
    ''');
  }

  void close() async {
    var db = await getDb();
    db.close();
  }

  ///crud

  Future create(GameModel game) async {
    final db = await getDb();
    final id = await db.insert(GameTable.tableName, game.toJson());
    return game.copy(id: id);
  }

  Future<GameModel?> read(int id) async {
    final db = await getDb();
    var map = await db.query(
      GameTable.tableName,
      columns: GameTable.values,
      where: '${GameTable.id} = ?',
      whereArgs: [id],
    );
    return map.isNotEmpty ? GameModel.fromJson(map.first) : null;
  }

  Future<List<GameModel>> readAll() async {
    final db = await getDb();
    final result = await db.query(
      GameTable.tableName,
    );
    return result.map((json) => GameModel.fromJson(json)).toList();
  }

  Future<int?> update(GameModel game) async {
    final db = await getDb();
    return await db.update(
      GameTable.tableName,
      game.toJson(),
      where: '${GameTable.id} = ?',
      whereArgs: [game.id],
    );
  }

  Future<int?> delete(GameModel game) async {
    final db = instance._database;
    return await db?.delete(GameTable.tableName,
        where: '${GameTable.id} = ?', whereArgs: [game.id]);
  }
}
