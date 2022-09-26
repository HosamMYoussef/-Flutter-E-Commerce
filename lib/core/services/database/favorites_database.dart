import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../constants.dart';
import '../../../model/Favorites_model.dart';

class LocalDatabaseFavorites {
  LocalDatabaseFavorites._();
  static final LocalDatabaseFavorites db = LocalDatabaseFavorites._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String _path = join(await getDatabasesPath(), 'favoritesProducts.db');

    Database _database = await openDatabase(_path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE favoritesProducts (
        name TEXT NOT NULL,
        image TEXT NOT NULL,
        price TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        productId TEXT NOT NULL)
      ''');
    });

    return _database;
  } 

  Future<List<FavortiesProdcutModel>> getAllProdcuts() async {
    Database _db = await database;
    List<Map> maps = await _db.query('favoritesProducts');
    List<FavortiesProdcutModel> list = maps.isNotEmpty
        ? maps.map((product) => FavortiesProdcutModel.fromJson(product)).toList()
        : [];

    return list;
  }

  insert(FavortiesProdcutModel model) async {
    Database _db = await database;
    await _db.insert(
      'favoritesProducts',
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
   deleteProduct(String productId) async {
    Database _db = await database;
    await _db.delete(
      'favoritesProducts',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  deleteAllProducts() async {
    Database _db = await database;
    await _db.delete('favoritesProducts');
  }

  update(FavortiesProdcutModel favortesModel) async {
    Database _db = await database;
    await _db.update(
      'favoritesProducts',
      favortesModel.toJson(),
      where: 'productId = ?',
      whereArgs: [favortesModel.productId],
    );
  }
}
