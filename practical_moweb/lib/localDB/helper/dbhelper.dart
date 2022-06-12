import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:practical_moweb/localDB/model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  Database? _db = null;
  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Product(productId String PRIMARY KEY, productName TEXT, productImage TEXT, size TEXT, specialPrice TEXT, mainPrice TEXT, cateName TEXT, isAdded INTEGER)");
  }

  void saveProduct(Product product) async {
    var dbClient = await db;
    await dbClient?.transaction((txn) async {
      return await txn.rawInsert(
          "INSERT INTO Product(productId, productName, productImage, size, specialPrice, mainPrice, cateName, isAdded) VALUES('" +
              product.productId +
              "', '" +
              product.productName +
              "','" +
              product.productImage +
              "','" +
              product.size +
              "','" +
              product.specialPrice +
              "','" +
              product.mainPrice +
              "','" +
              product.cateName +
              "','" +
          product.isAdded.toString() +
              "')");
    });
  }

  Future<List<Product>> getProduct(productName) async {
    var dbClient = await db;
    List<Map>? list = await dbClient?.rawQuery('SELECT * FROM Product WHERE cateName=?', ['$productName']);
    List<Product> product = [];
    for (int i = 0; i < list!.length; i++) {
      product.add(Product(
          list[i]["productId"],
          list[i]["productName"],
          list[i]["productImage"],
          list[i]["size"],
          list[i]["specialPrice"],
          list[i]["mainPrice"],
          list[i]["cateName"],
          list[i]["isAdded"]=="0"?false:true));
    }
    print(product.length);
    return product;
  }
}
