import 'package:e_i_register/model/expense_category_model/expense_categories.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String columnExpenseCategoryId = 'expense_category_id';
const String columnExpenseCategoryName = 'expense_category_name';
const String columnExpenseCategoryCreatedAt = 'expense_category_created_at';
const String columnExpenseCategoryUpdatedAt = 'expense_category_updated_at';

const List<String> expenseCategorycolumns = [
  columnExpenseCategoryId,
  columnExpenseCategoryName,
  columnExpenseCategoryCreatedAt,
  columnExpenseCategoryUpdatedAt,
];

class ExpenseCategoryDbHelper {
  // DbHelperをinstance化する
  static final ExpenseCategoryDbHelper expensecategoryinstance = ExpenseCategoryDbHelper._createInstance();
  static Database? _expensecategorydatabase;

  ExpenseCategoryDbHelper._createInstance();

  // databaseをオープンしてインスタンス化する
  Future<Database> get expensecategorydatabase async {
    return _expensecategorydatabase ??= await _initDB(); // 初回だったら_initDB()=DBオープンする
  }

  // データベースをオープンする
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'expensecategories.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onExpenseCategoryCreate, // cats.dbがなかった時の処理を指定する（DBは勝手に作られる）
    );
  }

  Future _onExpenseCategoryCreate(Database database, int version) async {
    await database.execute('''
      CREATE TABLE expensecategories(
        expense_category_code INTEGER PRIMARY KEY,
        expense_category_name TEXT,
        expense_category_created_at TEXT,
        expense_category_updated_at TEXT
      )
    ''');
    getExpenseCategoryName(database);
  }

  Future<List<Expensecategories>> selectAllExpenseCategories() async {
    final db = await expensecategoryinstance.expensecategorydatabase;

    final expensecategoriesData = await db.query('expensecategories');          // 条件指定しないでcatsテーブルを読み込む

    return expensecategoriesData.map((json) => Expensecategories.fromJson(json)).toList();    // 読み込んだテーブルデータをListにパースしてreturn
  }

  Future<Expensecategories> expenseCategoryData(int id) async {
    final db = await expensecategoryinstance.expensecategorydatabase;
    var expensecategory = [];
    expensecategory = await db.query(
      'expensecategories',
      columns: expenseCategorycolumns,
      where: 'expense_category_code = ?',                     // 渡されたidをキーにしてcatsテーブルを読み込む
      whereArgs: [id],
    );
    return Expensecategories.fromJson(expensecategory.first);      // 1件だけなので.toListは不要
  }

  Future expenseCategoriesInsert(Expensecategories expensecategories) async {
    final db = await expensecategorydatabase;
    return await db.insert(
        'expensecategories',
        expensecategories.toJson()                         // cats.dartで定義しているtoJson()で渡されたcatsをパースして書き込む
    );
  }

  Future expenseCategoriesUpdate(Expensecategories expensecategories) async {
    final db = await expensecategorydatabase;
    return await db.update(
      'expensecategories',
      expensecategories.toJson(),
      where: 'expense_category_code = ?',                   // idで指定されたデータを更新する
      whereArgs: [expensecategories.expense_category_code],
    );
  }

  Future expenseCategoriesDelete(int id) async {
    final db = await expensecategoryinstance.expensecategorydatabase;
    return await db.delete(
      'expensecategories',
      where: 'expense_category_code = ?',                   // idで指定されたデータを削除する
      whereArgs: [id],
    );
  }

  static Future<List> getExpenseCategoryName(Database database) async {
    List<Expensecategories> list = [
      Expensecategories(
        expense_category_code: 0,
        expense_category_name: '食費',
        expense_category_created_at: DateTime.now(),
        expense_category_updated_at: DateTime.now(),
      ),
      Expensecategories(
        expense_category_code: 1,
        expense_category_name: '交通費',
        expense_category_created_at: DateTime.now(),
        expense_category_updated_at: DateTime.now(),
      ),
      Expensecategories(
        expense_category_code: 2,
        expense_category_name: '固定費',
        expense_category_created_at: DateTime.now(),
        expense_category_updated_at: DateTime.now(),
      ),
      Expensecategories(
        expense_category_code: 3,
        expense_category_name: '交際費',
        expense_category_created_at: DateTime.now(),
        expense_category_updated_at: DateTime.now(),
      ),
    ];

    List<Map<String, dynamic>> maps = await database.query('expensecategories');
    if (maps.isNotEmpty) {
      return maps.map((map) => Expensecategories.fromJson(map)).toList();
    } else {
      for (int i = 0; i < list.length; i++) {
        await addExpenseCategoryName(list[i]);
      }
    }
    return list;
    }

  static Future<int> addExpenseCategoryName(Expensecategories expensecategories) async {
    final db = await expensecategoryinstance.expensecategorydatabase;
    return db.insert(
      'expensecategories',
      expensecategories.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}