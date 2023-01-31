import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/expense_category_model/expense_category_db_helper.dart';
import '../../model/expense_model/expense_db_helper.dart';
import '../../model/expense_model/expenses.dart';
import '../../model/income_category_model/income_category_db_helper.dart';
import '../../model/income_model/income_db_helper.dart';
import '../../model/income_model/incomes.dart';
import '../../model/payment_method_model/payment_method_db_helper.dart';


class ExpenseDetailEdit extends StatefulWidget {
  final Expenses? expenses;
  final Incomes? incomes;

  const ExpenseDetailEdit({Key? key, this.expenses, this.incomes}) : super(key: key);

  @override
  State<ExpenseDetailEdit> createState() => _ExpenseDetailEditState();
}

class _ExpenseDetailEditState extends State<ExpenseDetailEdit> {
  //expense

  late int expense_id;
  late int expense_category_code;
  late String expense_genre_code;
  late int payment_method_id;
  late int expense_total_money;
  late int expense_consumption_tax;
  late int expense_amount_including_tax;
  late DateTime expense_datetime;
  late String expense_memo;
  late DateTime expense_created_at;
  late DateTime expense_updated_at;
  // final List<String> _expense_category = <String>['支出カテゴリの選択','食費', '交通費', '固定費', '交際費'];
  // late String _expense_category_selected;
  // final List<String> _payment= <String>['支払い方法を選択','現金', 'クレジット', '電子マネー'];
  // late String _payment_selected;
  //income
  late int income_id;
  late int income_category_code;
  late int income_money;
  late DateTime income_day;
  late String income_memo;
  late DateTime income_created_at;
  late DateTime income_updated_at;
  // late String _income_category_selected;

  String which = '通常';
  dynamic expenseDateTime;
  dynamic expenseDateFormat;
  dynamic incomeDateTime;
  dynamic incomeDateFormat;

  late Map<int, String> _namemap;
  int nameselected = 0;

  late Map<int, String> _expensecategorymap;
  int expensecategoryselected = 0;

  late Map<int, String> _paymentmethodmap;
  int paymentmethodselected = 0;

  int maxIdCount = 0;
  int idCount = 0;

  int maxExpenseCategoryIdCount = 0;
  int ExpenseCategoryIdCount = 0;

  int maxPaymentMethodIdCount = 0;
  int PaymentMethodIdCount = 0;

// Stateのサブクラスを作成し、initStateをオーバーライドすると、wedgit作成時に処理を動かすことができる。
// ここでは、各項目の初期値を設定する
  @override
  void initState() {
    super.initState();
    // expense
    expense_id = widget.expenses?.expense_id ?? 0;
    expense_category_code = widget.expenses?.expense_category_code ?? 0;
    expense_genre_code = widget.expenses?.expense_genre_code ?? '通常';
    payment_method_id = widget.expenses?.payment_method_id ?? 0;
    expense_total_money = widget.expenses?.expense_total_money ?? 0;
    expense_consumption_tax = widget.expenses?.expense_consumption_tax ?? 0;
    expense_amount_including_tax = widget.expenses?.expense_amount_including_tax ?? 0;
    expense_datetime = widget.expenses?.expense_datetime ?? DateTime.now();
    expense_memo = widget.expenses?.expense_memo ?? '';
    expense_created_at = widget.expenses?.expense_created_at ?? DateTime.now();
    expense_updated_at = widget.expenses?.expense_updated_at ?? DateTime.now();
    // _expense_category_selected = widget.expenses?.expense_category_code ?? '支出カテゴリの選択';
    // _payment_selected = widget.expenses?.payment_method_id ?? '支払い方法を選択';
    //income
    income_id = widget.incomes?.income_id ?? 0;
    income_category_code = widget.incomes?.income_category_code ?? 0;
    income_money = widget.incomes?.income_money ?? 0;
    income_day = widget.incomes?.income_day ?? DateTime.now();
    income_memo = widget.incomes?.income_memo ?? '';
    income_created_at = widget.incomes?.income_created_at ?? DateTime.now();
    income_updated_at = widget.incomes?.income_updated_at ?? DateTime.now();
    // _income_category_selected = widget.incomes?.income_category_code ?? '収入カテゴリの選択';
    //共通
    expenseDateTime = DateTime.now();
    expenseDateFormat = DateFormat("yyyy年MM月dd日").format(expenseDateTime);

    incomeDateTime = DateTime.now();
    incomeDateFormat = DateFormat("yyyy年MM月dd日").format(incomeDateTime);

    _namemap = {};
    _getname();
    nameselected = 0;
    _getmaxid();

    _expensecategorymap = {};
    _getexpensecategory();
    expensecategoryselected = 0;
    _getexpensecategorymaxid();

    _paymentmethodmap = {};
    _getpaymentmethod();
    paymentmethodselected = 0;
    _getpaymentmethodmaxid();

  }

  _getname() async {
    _namemap = await getincomecategoryname() as Map<int, String>;
  }

  _getexpensecategory() async {
    _expensecategorymap = await getexpensecategoryname() as Map<int, String>;
  }

  _getpaymentmethod() async {
    _paymentmethodmap = await getpaymentmethodname() as Map<int, String>;
  }

  _getmaxid() async {
    maxIdCount = await getmaxincomecategory();
  }

  _getexpensecategorymaxid() async {
    maxExpenseCategoryIdCount = await getmaxexpensecategory();
  }

  _getpaymentmethodmaxid() async {
    maxPaymentMethodIdCount = await getmaxpaymentmethod();
  }

  static Future<Map<int, String>> getincomecategoryname() async {
    final db = await IncomeCategoryDbHelper.incomecategoryinstance.incomecategorydatabase;
    final rows = await db.rawQuery('SELECT income_category_code,income_category_name FROM incomecategories');
    // rows.map((e) => Dogs.fromJson(e));
    int length = rows.length;
    var category = <int, String>{};
    // print(length);
    // print(rows);

    for(int i = 0; i < length; i++) {
      int key = rows[i]['income_category_code'] as int;
      String value = rows[i]['income_category_name'] as String;
      category[key] = value;
      // print(key.runtimeType);
      // print(value.runtimeType);
      // print(category);
    }

    // print(category)
    // print(rows[1]['_dogid']);
    // print(rows);
    return category;
  }

  static Future<Map<int, String>> getexpensecategoryname() async {
    final db = await ExpenseCategoryDbHelper.expensecategoryinstance.expensecategorydatabase;
    final rows = await db.rawQuery('SELECT expense_category_code,expense_category_name FROM expensecategories');
    // rows.map((e) => Dogs.fromJson(e));
    int length = rows.length;
    var category = <int, String>{};
    // print(length);
    // print(rows);

    for(int i = 0; i < length; i++) {
      int key = rows[i]['expense_category_code'] as int;
      String value = rows[i]['expense_category_name'] as String;
      category[key] = value;
      // print(key.runtimeType);
      // print(value.runtimeType);
      // print(category);
    }

    // print(category)
    // print(rows[1]['_dogid']);
    // print(rows);
    return category;
  }

  static Future<Map<int, String>> getpaymentmethodname() async {
    final db = await PaymentMethodDbHelper.paymentmethodinstance.paymentmethoddatabase;
    final rows = await db.rawQuery('SELECT payment_method_id,payment_method_name FROM paymentmethods');
    // rows.map((e) => Dogs.fromJson(e));
    int length = rows.length;
    var category = <int, String>{};
    // print(length);
    // print(rows);

    for(int i = 0; i < length; i++) {
      int key = rows[i]['payment_method_id'] as int;
      String value = rows[i]['payment_method_name'] as String;
      category[key] = value;
      // print(key.runtimeType);
      // print(value.runtimeType);
      // print(category);
    }

    // print(category)
    // print(rows[1]['_dogid']);
    // print(rows);
    return category;
  }

  static Future<int> getmaxincomecategory() async {
    final db = await IncomeCategoryDbHelper.incomecategoryinstance.incomecategorydatabase;
    final rows = await db.rawQuery('SELECT max(income_category_code) FROM incomecategories');
    int maxid = rows[0]['max(income_category_code)'] as int;

    // print(maxid);
    // print(maxid.runtimeType);
    return maxid;
  }

  static Future<int> getmaxexpensecategory() async {
    final db = await ExpenseCategoryDbHelper.expensecategoryinstance.expensecategorydatabase;
    final rows = await db.rawQuery('SELECT max(expense_category_code) FROM expensecategories');
    int maxid = rows[0]['max(expense_category_code)'] as int;

    // print(maxid);
    // print(maxid.runtimeType);
    return maxid;
  }

  static Future<int> getmaxpaymentmethod() async {
    final db = await PaymentMethodDbHelper.paymentmethodinstance.paymentmethoddatabase;
    final rows = await db.rawQuery('SELECT max(payment_method_id) FROM paymentmethods');
    int maxid = rows[0]['max(payment_method_id)'] as int;

    // print(maxid);
    // print(maxid.runtimeType);
    return maxid;
  }

/*
  void _onChangedExpenseCategory(String? value) {
    setState(() {
      _expense_category_selected = value!;
      expense_category_code = _expense_category_selected;
    });
  }

  void _onChangedIncomeCategory(String? value) {
    setState(() {
      _income_category_selected = value!;
      income_category_code = _income_category_selected;
    });
  }

  void _onChangedPayment(String? value) {
    setState(() {
      _payment_selected = value!;
      payment_method_id = _payment_selected;
    });
  }

 */

  void _onChangedGenre(String? value) {
    setState(() {
      which = value!;
      expense_genre_code = which;
    });
  }

  _expenseDatePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
        locale: const Locale("ja"),
        context: context,
        initialDate: expenseDateTime,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    print("aaa");
    if (datePicked != null && datePicked != expenseDateTime) {
      setState(() {
        expenseDateFormat = DateFormat("yyyy年MM月dd日").format(datePicked);
        expenseDateTime = datePicked;
        expense_datetime = expenseDateTime;
        print("bbb");
      });
    }
  }

  _incomeDatePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
        locale: const Locale("ja"),
        context: context,
        initialDate: incomeDateTime,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (datePicked != null && datePicked != incomeDateTime) {
      setState(() {
        incomeDateFormat = DateFormat("yyyy年MM月dd日").format(datePicked);
        incomeDateTime = datePicked;
        income_day = incomeDateTime;
      });
    }
  }

  void createOrUpdateExpense() async {
    final isUpdate = (widget.expenses != null);     // 画面が空でなかったら

    if (isUpdate) {
      await updateExpense();                        // updateの処理
    } else {
      await createExpense();                        // insertの処理
    }
    Navigator.of(context).pop();                // 前の画面に戻る
  }

  void createOrUpdateIncome() async {
    final isUpdate = (widget.incomes != null);     // 画面が空でなかったら

    if (isUpdate) {
      await updateIncome();                        // updateの処理
    } else {
      await createIncome();                        // insertの処理
    }
    Navigator.of(context).pop();                // 前の画面に戻る
  }

  // 更新処理の呼び出し
  Future updateExpense() async {
    final expense = widget.expenses!.copy(              // 画面の内容をcatにセット
      expense_category_code: expense_category_code,
      expense_genre_code: expense_genre_code,
      payment_method_id: payment_method_id,
      expense_amount_including_tax: expense_amount_including_tax,
      expense_datetime: expense_datetime,
      expense_memo: expense_memo,
      expense_updated_at: expense_updated_at,
    );

    await ExpenseDbHelper.expenseinstance.expenseupdate(expense);        // catの内容で更新する
  }

  Future updateIncome() async {
    final income = widget.incomes!.copy(              // 画面の内容をcatにセット
      income_category_code: income_category_code,
      income_money: income_money,
      income_day: income_day,
      income_memo: income_memo,
      income_updated_at: income_updated_at,
    );

    await IncomeDbHelper.incomeinstance.incomeupdate(income);        // catの内容で更新する
  }

  // db処理メソッド
  Future createExpense() async {
    final expense = Expenses(                           // 入力された内容をcatにセット
      expense_id: expense_id,
      expense_category_code: ++maxExpenseCategoryIdCount,
      expense_genre_code: expense_genre_code,
      payment_method_id: payment_method_id,
      expense_total_money: 0,
      expense_consumption_tax: 0,
      expense_amount_including_tax: expense_amount_including_tax,
      expense_datetime: expense_datetime,
      expense_memo: expense_memo,
      expense_created_at: expense_created_at,
      expense_updated_at: expense_updated_at,
    );
    await ExpenseDbHelper.expenseinstance.expenseinsert(expense);        // catの内容で追加する
  }

  Future createIncome() async {
    idCount = ++maxIdCount;
    final income = Incomes(                           // 入力された内容をcatにセット
      income_id: idCount,
      income_category_code: income_category_code,
      income_money: income_money,
      income_day: income_day,
      income_memo: income_memo,
      income_created_at: income_created_at,
      income_updated_at: income_updated_at,
    );
    await IncomeDbHelper.incomeinstance.incomeinsert(income);        // catの内容で追加する
  }

// 詳細編集画面を表示する
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 50,),
          onPressed: () => Navigator.of(context).pop(),  // 遷移元のページをpop
        ),

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.camera_alt, size: 40,),
            onPressed: () {},  //カメラボタンの遷移
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [
                Container(
                  child: const TabBar(
                    labelColor: Colors.orange,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(text: '支出'),
                      Tab(text: '収入'),
                    ],
                  ),
                ),

                const SizedBox(height: 20,),

                Container(
                  height: 480,
                  child: TabBarView(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[
                                  Radio(
                                    value: '通常',
                                    groupValue: which,
                                    onChanged: _onChangedGenre
                                  ),
                                  const Text('通常', style: TextStyle(fontSize: 25),),
                                  Radio(
                                    value: '後払い',
                                    groupValue: which,
                                    onChanged: _onChangedGenre
                                  ),
                                  const Text('後払い', style: TextStyle(fontSize: 25),),
                                ],
                              ),
                            ),
                            Container(
                              width:280,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.black)
                                )
                              ),
                              child: Center(
                                child: TextFormField(
                                    initialValue: expense_amount_including_tax.toString(), style: const TextStyle(fontSize: 35),
                                    textAlign: TextAlign.right,
                                    keyboardType: TextInputType.number,
                                    onChanged: (change_expense_money) => setState(() => expense_amount_including_tax = int.parse(change_expense_money))
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                             child: OutlinedButton(
                               child:Text(expenseDateFormat),
                               style: OutlinedButton.styleFrom(
                                   foregroundColor: Colors.black,
                             ),
                               onPressed: () {
                                 _expenseDatePicker(context);
                               }),
                           ),
                            const SizedBox(height: 10,),
                            Container(
                              width: 220,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 220,
                                    height: 50,
                                    child: DropdownButton(
                                      value: expensecategoryselected,
                                      onChanged: (newValue) {
                                        setState(() {
                                          expensecategoryselected = newValue!;
                                        });
                                      },
                                      items: _expensecategorymap.entries.map((entry) {
                                        return DropdownMenuItem(
                                          child: Text(entry.value),
                                          value: entry.key,
                                        );
                                      }).toList(),
                                      hint: Text('支出カテゴリの選択'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              width: 220,
                              child: Row(
                                children: <Widget>[
                                  DropdownButton(
                                    value: paymentmethodselected,
                                    onChanged: (newValue) {
                                      setState(() {
                                        paymentmethodselected = newValue!;
                                      });
                                    },
                                    items: _paymentmethodmap.entries.map((entry) {
                                      return DropdownMenuItem(
                                        child: Text(entry.value),
                                        value: entry.key,
                                      );
                                    }).toList(),
                                    hint: Text('支払い方法の選択'),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: const Align(
                                alignment: Alignment(-0.7,0),
                                child: Text('メモ', style: TextStyle(fontSize: 25),),
                              ),
                            ),
                            Container(
                              width: 280,
                              child: TextFormField(
                                initialValue: expense_memo,
                                decoration: const InputDecoration(
                                  hintText: 'メモを入力してください',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10,
                                    )
                                ),
                                onChanged: (expense_change_memo) => setState(() => this.expense_memo = expense_change_memo),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              height: 50,
                              width: 100,
                              child: ElevatedButton(
                                child: const Text('登録', style: TextStyle(fontSize: 20),),
                                onPressed: createOrUpdateExpense,
                              ),
                            ),
                          ],
                        ),
                      ),



































                      //ここから収入
                            Container(
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(height: 50,),
                                  Container(
                                    width:280,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(color: Colors.black)
                                        )
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                          initialValue: income_money.toString(), style: const TextStyle(fontSize: 35),
                                          textAlign: TextAlign.right,
                                          keyboardType: TextInputType.number,
                                          onChanged: (change_income_money) => setState(() => income_money = int.parse(change_income_money))
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    child: OutlinedButton(
                                        child:Text(incomeDateFormat),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                        ),
                                        onPressed: () {
                                          _incomeDatePicker(context);
                                        }),
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    width: 220,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(),
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 220,
                                          height: 50,
                                          child: DropdownButton(
                                            value: nameselected,
                                            onChanged: (newValue) {
                                              setState(() {
                                                nameselected = newValue!;
                                              });
                                            },
                                            items: _namemap.entries.map((entry) {
                                              return DropdownMenuItem(
                                                child: Text(entry.value),
                                                value: entry.key,
                                              );
                                            }).toList(),
                                            hint: Text('収入カテゴリの選択'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Container(
                                    child: const Align(
                                      alignment: Alignment(-0.7,0),
                                      child: Text('メモ', style: TextStyle(fontSize: 25),),
                                    ),
                                  ),
                                  Container(
                                    width: 280,
                                    child: TextFormField(
                                      initialValue: income_memo,
                                      decoration: const InputDecoration(
                                          hintText: 'メモを入力してください',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 10,
                                          )
                                      ),
                                      onChanged: (income_change_memo) => setState(() => this.income_memo = income_change_memo),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Container(
                                    height: 50,
                                    width: 100,
                                    child: ElevatedButton(
                                      child: const Text('登録', style: TextStyle(fontSize: 20),),
                                      onPressed: createOrUpdateIncome,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ],),
            ),
          ],),
      ),
    );
  }
}