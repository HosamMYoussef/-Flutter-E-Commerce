import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../constants.dart';
import '../../../model/cart_product_model.dart';

class LocalDatabaseCart {
  LocalDatabaseCart._();
  static final LocalDatabaseCart db = LocalDatabaseCart._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String _path = join(await getDatabasesPath(), 'CartProducts.db');

    Database _database = await openDatabase(_path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE cartProducts (
        name TEXT NOT NULL,
        image TEXT NOT NULL,
        price TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        productId TEXT NOT NULL)
      ''');
    });

    return _database;
  } 

  Future<List<CartProductModel>> getAllProdcuts() async {
    Database _db = await database;
    List<Map> maps = await _db.query('cartProducts');
    List<CartProductModel> list = maps.isNotEmpty
        ? maps.map((product) => CartProductModel.fromJson(product)).toList()
        : [];

    return list;
  }

  insert(CartProductModel model) async {
    Database _db = await database;
    await _db.insert(
      'cartProducts',
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
   deleteProduct(String productId) async {
    Database _db = await database;
    await _db.delete(
      'cartProducts',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  deleteAllProducts() async {
    Database _db = await database;
    await _db.delete('cartProducts');
  }

  update(CartProductModel cartModel) async {
    Database _db = await database;
    await _db.update(
      'cartProducts',
      cartModel.toJson(),
      where: 'productId = ?',
      whereArgs: [cartModel.productId],
    );
  }
}
