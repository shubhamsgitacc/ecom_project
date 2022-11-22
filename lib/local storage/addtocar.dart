import 'dart:io';

import 'package:ecommerce/models/addtocartmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DbCartHandler {
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
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: _oncreate);
    return db;
  }

  _oncreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE addtocarts(id INTEGER, name TEXT, image TEXT,actualprice TEXT,finalprice TEXT,quantity INTEGER,weight TEXT)');
  }

  Future<CartModels> insertCart(CartModels cartModels) async {
    var dbClient = await db;
    await dbClient!.insert('addtocarts', cartModels.toMap());
    return cartModels;
  }

  Future<List<CartModels>> geCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryresult =
        await dbClient!.query('addtocarts');
      
    // print(queryresult);
    return queryresult.map((e) => CartModels.fromMap(e)).toList();
  }

  Future<int> deleteFroCart(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('addtocarts', where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateQuantity(CartModels cartModels) async {
    var dbClient = await db;
    return await dbClient!.update('addtocarts', cartModels.toMap(),
        where: 'id=?', whereArgs: [cartModels.id]);
  }

  Future getProduct(int id) async {
    var dbClient = await db;
    final maps =
        await dbClient!.query('addtocarts', where: 'id=?', whereArgs: [id]);
    return maps;
  }

  Future<CartModels> getdatas(int id) async {
    var dbClient = await db;
    final maps =
        await dbClient!.query('addtocarts', where: 'id=?', whereArgs: [id]);
    return CartModels.fromMap(maps.first);
  }

  getBlockedClients() async {
    final dbClient = await db;
    var res = await dbClient!.query('addtocarts');
    List<CartModels> list =
        res.toList().map((c) => CartModels.fromMap(c)).toList();
    print(list);
    return list;
  }

  Future<List<Map<String, dynamic>>> getSpecdata(int id) async {
    final dbClient = await db;
    var res =
        await dbClient!.query('addtorcarts', where: 'id=?', whereArgs: [id]);
    return res;
  }

  // getOneuser(int id) async {
  //   final dbClient = await db;
  //   final List<String,dynamic> maps=await dbClient.
  // }

  Future readTable() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query('addtocarts');

    // maps.forEach((elment) {});
    // print(jsonEncode(maps) + 'helo');
    print(maps.toString() + 'im form maps');
    return maps;
  }
  //  Future<List<CartModels>> geCartList() async {
  //   var dbClient = await db;
  //   final List<Map<String, Object?>> queryresult =
  //       await dbClient!.query('addtocarts');

  //   print(queryresult);
  //   return queryresult.map((e) => CartModels.fromMap(e)).toList();
  // }
}
