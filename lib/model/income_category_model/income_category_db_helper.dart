import 'package:e_i_register/model/income_category_model/income_categories.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String columnIncomeCategoryCode = 'income_category_code';
const String columnIncomeCategoryName = 'income_category_name';
const String columnIncomeCategoryCreatedAt = 'income_category_created_at';
const String columnIncomeCategoryUpdatedAt = 'income_category_updated_at';


const List<String> incomeCategorycolumns = [
  columnIncomeCategoryCode,
  columnIncomeCategoryName,
  columnIncomeCategoryCreatedAt,
  columnIncomeCategoryUpdatedAt,
];

class IncomeCategoryDbHelper {
  // DbHelperをinstance化する
  static final IncomeCategoryDbHelper incomecategoryinstance = IncomeCategoryDbHelper._createInstance();
  static Database? _incomecategorydatabase;

  IncomeCategoryDbHelper._createInstance();

  // databaseをオープンしてインスタンス化する
  Future<Database> get incomecategorydatabase async {
    return _incomecategorydatabase ??= await _initDB(); // 初回だったら_initDB()=DBオープンする
  }

  // データベースをオープンする
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'incomecategories.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onIncomeCategoryCreate, // cats.dbがなかった時の処理を指定する（DBは勝手に作られる）
    );
  }

  Future _onIncomeCategoryCreate(Database database, int version) async {
    await database.execute('''
      CREATE TABLE incomecategories(
        income_category_code INTEGER PRIMARY KEY,
        income_category_name TEXT,
        income_category_created_at TEXT,
        income_category_updated_at TEXT
      )
    ''');
    getIncomeCategoryName(database);
  }

  Future<List<Incomecategories>> selectAllIncomeCategories() async {
    final db = await incomecategoryinstance.incomecategorydatabase;

    final incomecategoriesData = await db.query('incomecategories');          // 条件指定しないでcatsテーブルを読み込む

    return incomecategoriesData.map((json) => Incomecategories.fromJson(json)).toList();    // 読み込んだテーブルデータをListにパースしてreturn
  }

  Future<Incomecategories> incomeCategoryData(int id) async {
    final db = await incomecategoryinstance.incomecategorydatabase;
    var incomecategory = [];
    incomecategory = await db.query(
      'incomecategories',
      columns: incomeCategorycolumns,
      where: 'income_category_code = ?',                     // 渡されたidをキーにしてcatsテーブルを読み込む
      whereArgs: [id],
    );
    return Incomecategories.fromJson(incomecategory.first);      // 1件だけなので.toListは不要
  }

  Future incomeCategoriesInsert(Incomecategories incomecategories) async {
    final db = await incomecategorydatabase;
    return await db.insert(
        'incomecategories',
        incomecategories.toJson()                         // cats.dartで定義しているtoJson()で渡されたcatsをパースして書き込む
    );
  }

  Future incomeCategoriesUpdate(Incomecategories incomecategories) async {
    final db = await incomecategorydatabase;
    return await db.update(
      'incomecategories',
      incomecategories.toJson(),
      where: 'income_category_code = ?',                   // idで指定されたデータを更新する
      whereArgs: [incomecategories.income_category_code],
    );
  }

  Future incomeCategoriesDelete(int id) async {
    final db = await incomecategoryinstance.incomecategorydatabase;
    return await db.delete(
      'incomecategories',
      where: 'income_category_code = ?',                   // idで指定されたデータを削除する
      whereArgs: [id],
    );
  }

  static Future<List> getIncomeCategoryName(Database database) async {
    List<Incomecategories> list = [
      Incomecategories(
        income_category_code: 0,
        income_category_name: '給料',
        income_category_created_at: DateTime.now(),
        income_category_updated_at: DateTime.now(),
      ),
      Incomecategories(
        income_category_code: 1,
        income_category_name: 'お小遣い',
        income_category_created_at: DateTime.now(),
        income_category_updated_at: DateTime.now(),
      ),
    ];

    List<Map<String, dynamic>> maps = await database.query('incomecategories');
    if (maps.isNotEmpty) {
      return maps.map((map) => Incomecategories.fromJson(map)).toList();
    } else {
      for (int i = 0; i < list.length; i++) {
        await addIncomeCategoryName(list[i]);
      }
    }
    return list;
  }

  static Future<int> addIncomeCategoryName(Incomecategories incomecategories) async {
    final db = await incomecategoryinstance.incomecategorydatabase;
    return db.insert(
      'incomecategories',
      incomecategories.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}