import 'dart:io';

import 'package:ecommerce/models/favmodel.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbFAVHandlder {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initdatabase();
    return _db;
  }

  initdatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'favs.db');
    var db = await openDatabase(path, version: 1, onCreate: _oncreate);
    return db;
  }

  _oncreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE Favlistwo(id INTEGER, name TEXT, image TEXT)');
  }

  Future<FavModels> insertFAV(FavModels favModels) async {
    var dbClient = await db;
    await dbClient!.insert('Favlistwo', favModels.toMap());
    return favModels;
  }

  Future<List<FavModels>> getFavList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryresult =
        await dbClient!.query('Favlistwo');

    print(queryresult);
    return queryresult.map((e) => FavModels.fromMap(e)).toList();
  }

  Future<int> deleteFromFav(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('Favlistwo', where: 'id=?', whereArgs: [id]);
  }
}
