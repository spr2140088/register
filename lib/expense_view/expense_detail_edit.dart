import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/expense_db_helper.dart';
import '../model/expenses.dart';

class ExpenseDetailEdit extends StatefulWidget {
  final Expenses? expenses;

  const ExpenseDetailEdit({Key? key, this.expenses}) : super(key: key);

  @override
  _ExpenseDetailEditState createState() => _ExpenseDetailEditState();
}

class _ExpenseDetailEditState extends State<ExpenseDetailEdit> {
  late int expense_id;
  late String expense_category_code;
  late String expense_genre_code;
  late String payment_method_id;
  late int expense_total_money;
  late int expense_consumption_tax;
  late int expense_amount_including_tax;
  late DateTime expense_datetime;
  late String expense_memo;
  late DateTime expense_created_at;
  late DateTime expense_updated_at;
  final List<String> _category = <String>['支出カテゴリの選択','食費', '交通費', '固定費', '交際費'];
  late String _category_selected;
  final List<String> _payment= <String>['支払い方法を選択','現金', 'クレジット', '電子マネー'];
  late String _payment_selected;
  String which = '通常';
  String? incomeItem = '収入カテゴリの選択';
  dynamic dateTime;
  dynamic dateFormat;

// Stateのサブクラスを作成し、initStateをオーバーライドすると、wedgit作成時に処理を動かすことができる。
// ここでは、各項目の初期値を設定する
  @override
  void initState() {
    super.initState();
    expense_id = widget.expenses?.expense_id ?? 0;
    expense_category_code = widget.expenses?.expense_category_code ?? '';
    expense_genre_code = widget.expenses?.expense_genre_code ?? '通常';
    payment_method_id = widget.expenses?.payment_method_id ?? '';
    expense_total_money = widget.expenses?.expense_total_money ?? 0;
    expense_consumption_tax = widget.expenses?.expense_consumption_tax ?? 0;
    expense_amount_including_tax = widget.expenses?.expense_amount_including_tax ?? 0;
    expense_datetime = widget.expenses?.expense_datetime ?? DateTime.now();
    expense_memo = widget.expenses?.expense_memo ?? '';
    expense_created_at = widget.expenses?.expense_created_at ?? DateTime.now();
    expense_updated_at = widget.expenses?.expense_updated_at ?? DateTime.now();
    _category_selected = widget.expenses?.expense_category_code ?? '支出カテゴリの選択';
    _payment_selected = widget.expenses?.payment_method_id ?? '支払い方法を選択';
    dateTime = DateTime.now();
    dateFormat = DateFormat("yyyy年MM月dd日").format(dateTime);
  }

  void _onChangedCategory(String? value) {
    setState(() {
      _category_selected = value!;
      expense_category_code = _category_selected;
    });
  }

  void _onChangedPayment(String? value) {
    setState(() {
      _payment_selected = value!;
      payment_method_id = _payment_selected;
    });
  }

  void _onChangedGenre(String? value) {
    setState(() {
      which = value!;
      expense_genre_code = which;
    });
  }

  _datePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
        locale: const Locale("ja"),
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2003  ),
        lastDate: DateTime(2023));
    if (datePicked != null && datePicked != dateTime) {
      setState(() {
        dateFormat = DateFormat("yyyy年MM月dd日").format(datePicked);
        dateTime = datePicked;
        expense_datetime = dateTime;
      });
    }
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
                                    onChanged: (change_money) => setState(() => expense_amount_including_tax = int.parse(change_money))
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                             child: OutlinedButton(
                               child:Text(dateFormat),
                               style: OutlinedButton.styleFrom(
                                   foregroundColor: Colors.black,
                             ),
                               onPressed: () {
                                 _datePicker(context);
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
                                    child: DropdownButton<String>(
                                      items: _category.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      value: _category_selected,
                                      onChanged: _onChangedCategory,
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
                                  DropdownButton<String>(
                                    items: _payment.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    value: _payment_selected,
                                    onChanged: _onChangedPayment,
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
        /*
                            Container(
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(height: 50,),
                                  Container(
                                    width:280,
                                    child: Center(
                                        child: TextFormField(
                                          initialValue: '¥0', style: const TextStyle(fontSize: 35),
                                          textAlign: TextAlign.right,
                                          keyboardType: TextInputType.number,
                                        ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    width: 320,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(),
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              const Text('日付', style: TextStyle(fontSize: 15),),
                                              const SizedBox(width: 30,),
                                              Container(
                                                child: OutlinedButton(
                                                    child:Text(dateFormat),
                                                    style: OutlinedButton.styleFrom(
                                                      foregroundColor: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      _datePicker(context);
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    width: 240,
                                    decoration: const BoxDecoration(
                                      border: const Border(
                                        bottom: const BorderSide(),
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        DropdownButton(
                                          items: [
                                            const DropdownMenuItem(child: Text('収入カテゴリの選択', style: TextStyle(fontSize: 24),),
                                              value: '収入カテゴリの選択',
                                            ),
                                            const DropdownMenuItem(child: Text('aaa',style: TextStyle(fontSize: 24),),
                                              value: 'aaa',
                                            ),
                                          ] ,
                                          onChanged: (String? value) {
                                            setState(() {
                                              incomeItem = value;
                                            });
                                          },
                                          value: incomeItem,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Container(
                                    child: Align(
                                      alignment: const Alignment(-0.7,0),
                                      child: const Text('メモ', style: TextStyle(fontSize: 25),),
                                    ),
                                  ),
                                  Container(
                                    width: 280,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(width: 2),
                                              ),
                                              contentPadding: EdgeInsets.symmetric(
                                                vertical: 10,
                                              )
                                          ),
                                        ),
                                  ),
                                  const SizedBox(height: 30,),
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
                      */
                    ],
                  ),
                ),
              ],),
            ),
          ],),
      ),
    );
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


  // 追加処理の呼び出し
  Future createExpense() async {
    final expense = Expenses(                           // 入力された内容をcatにセット
      expense_category_code: expense_category_code,
      expense_genre_code: expense_genre_code,
      payment_method_id: payment_method_id,
      expense_amount_including_tax: expense_amount_including_tax,
      expense_datetime: expense_datetime,
      expense_memo: expense_memo,
      expense_created_at: expense_created_at,
      expense_updated_at: expense_updated_at,
    );
    await ExpenseDbHelper.expenseinstance.expenseinsert(expense);        // catの内容で追加する
  }
}