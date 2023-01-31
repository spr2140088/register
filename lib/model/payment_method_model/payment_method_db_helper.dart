import 'package:e_i_register/model/payment_method_model/payment_method.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String columnPaymentMethodId = 'payment_method_id';
const String columnPaymentMethodName = 'payment_method_name';
const String columnPaymentMethodCreatedAt = 'payment_method_created_at';
const String columnPaymentMethodUpdatedAt = 'payment_method_updated_at';


const List<String> paymentMethodcolumns = [
  columnPaymentMethodId,
  columnPaymentMethodName,
  columnPaymentMethodCreatedAt,
  columnPaymentMethodUpdatedAt,
];

class PaymentMethodDbHelper {
  // DbHelperをinstance化する
  static final PaymentMethodDbHelper paymentmethodinstance = PaymentMethodDbHelper._createInstance();
  static Database? _paymentmethoddatabase;

  PaymentMethodDbHelper._createInstance();

  // databaseをオープンしてインスタンス化する
  Future<Database> get paymentmethoddatabase async {
    return _paymentmethoddatabase ??= await _initDB(); // 初回だったら_initDB()=DBオープンする
  }

  // データベースをオープンする
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'paymentmethods.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onPaymentMethodCreate, // cats.dbがなかった時の処理を指定する（DBは勝手に作られる）
    );
  }

  Future _onPaymentMethodCreate(Database database, int version) async {
    await database.execute('''
      CREATE TABLE paymentmethods(
        payment_method_id INTEGER PRIMARY KEY,
        payment_method_name TEXT,
        payment_method_created_at TEXT,
        payment_method_updated_at TEXT
      )
    ''');
    getPaymentMethodName(database);
  }

  Future<List<PaymentMethods>> selectAllPaymentMethods() async {
    final db = await paymentmethodinstance.paymentmethoddatabase;

    final paymentMethodsData = await db.query('paymentmethods');          // 条件指定しないでcatsテーブルを読み込む

    return paymentMethodsData.map((json) => PaymentMethods.fromJson(json)).toList();    // 読み込んだテーブルデータをListにパースしてreturn
  }

  Future<PaymentMethods> paymentMethodData(int id) async {
    final db = await paymentmethodinstance.paymentmethoddatabase;
    var paymentmethod = [];
    paymentmethod = await db.query(
      'paymentmethods',
      columns: paymentMethodcolumns,
      where: 'payment_method_id = ?',                     // 渡されたidをキーにしてcatsテーブルを読み込む
      whereArgs: [id],
    );
    return PaymentMethods.fromJson(paymentmethod.first);      // 1件だけなので.toListは不要
  }

  Future paymentMethodsInsert(PaymentMethods paymentmethods) async {
    final db = await paymentmethoddatabase;
    return await db.insert(
        'paymentmethods',
        paymentmethods.toJson()                         // cats.dartで定義しているtoJson()で渡されたcatsをパースして書き込む
    );
  }

  Future paymentMethodsUpdate(PaymentMethods paymentmethods) async {
    final db = await paymentmethoddatabase;
    return await db.update(
      'paymentmethods',
      paymentmethods.toJson(),
      where: 'payment_method_id = ?',                   // idで指定されたデータを更新する
      whereArgs: [paymentmethods.payment_method_id],
    );
  }

  Future paymentMethodsDelete(int id) async {
    final db = await paymentmethodinstance.paymentmethoddatabase;
    return await db.delete(
      'paymentmethods',
      where: 'payment_method_id = ?',                   // idで指定されたデータを削除する
      whereArgs: [id],
    );
  }

  static Future<List> getPaymentMethodName(Database database) async {
    List<PaymentMethods> list = [
      PaymentMethods(
          payment_method_id: 0,
          payment_method_name: '現金',
          payment_method_created_at: DateTime.now(),
          payment_method_updated_at: DateTime.now()
      ),
      PaymentMethods(
          payment_method_id: 1,
          payment_method_name: 'クレジット',
          payment_method_created_at: DateTime.now(),
          payment_method_updated_at: DateTime.now()
      ),
      PaymentMethods(
          payment_method_id: 2,
          payment_method_name: '電子マネー',
          payment_method_created_at: DateTime.now(),
          payment_method_updated_at: DateTime.now()
      ),
    ];

    List<Map<String, dynamic>> maps = await database.query('paymentmethods');
    if (maps.isNotEmpty) {
      return maps.map((map) => PaymentMethods.fromJson(map)).toList();
    } else {
      for (int i = 0; i < list.length; i++) {
        await addPaymentMethodName(list[i]);
      }
    }
    return list;
  }

  static Future<int> addPaymentMethodName(PaymentMethods paymentmethods) async {
    final db = await paymentmethodinstance.paymentmethoddatabase;
    return db.insert(
      'paymentmethods',
      paymentmethods.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}