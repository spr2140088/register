import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'expense_view/expense_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(                    //初期画面の設定
      title: '収支一覧',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routes: <String, WidgetBuilder>{
        '/': (_) => const ExpenseList(),

      },
    );
  }
}



/*
import 'package:e_i_register/expense_view/expense_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'model/expense_db_helper.dart';
import 'model/expenses.dart';

void main() {
  runApp(const MyApp());
}
var date = DateTime.now();
var dtFormat = DateFormat("yyyy-MM-dd");
String strDate = dtFormat.format(date);
var dt = DateTime.parse(strDate);


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.,
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const ExpenseList(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  final Expenses? expenses;

  const MyHomePage({Key? key, this.expenses}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int expense_id;
  late String expense_category_code;
  late String expense_genre_code;
  late String payment_method_id;
  late int expense_total_money;
  late int expense_consumption_tax;
  late int expense_amount_including_tax;
  late int expense_date_time_year;
  late int expense_date_time_month;
  late int expense_date_time_day;
  late String expense_memo;
  late DateTime expense_created_at;
  late DateTime expense_updated_at;
  final List<int> _years = <int>[2020,2021,2022,2023,2024];
  late int _year_selected;
  final List<int> _months = <int>[1,2,3,4,5,6,7,8,9,10,11,12];
  late int _month_selected;
  final List<int> _days = <int>[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31];
  late int _day_selected;
  final List<String> _category = <String>['食費', '交通費', '固定費', '交際費'];
  late String _category_selected;
  final List<String> _payment= <String>['現金', 'クレジット', '電子マネー'];
  late String _payment_selected;
  String? which = '通常';
  int yearValue = dt.year;
  int monthValue = dt.month;
  int dayValue = dt.day;
  String? expenseSelectedItem = '支出カテゴリの選択';
  String? paymentMethodItem = '支払方法を選択';
  String? incomeItem = '収入カテゴリの選択';
  static const int textExpandedFlex = 1; // 見出しのexpaded flexの比率
  static const int dataExpandedFlex = 4; // 項目のexpanede flexの比率

  @override
  void initState() {
    super.initState();
    expense_id = widget.expenses?.expense_id ?? 0;
    expense_category_code = widget.expenses?.expense_category_code ?? '1';
    expense_genre_code = widget.expenses?.expense_genre_code ?? '1';
    payment_method_id = widget.expenses?.payment_method_id ?? '1';
    expense_total_money = widget.expenses?.expense_total_money ?? 0;
    expense_consumption_tax = widget.expenses?.expense_consumption_tax ?? 0;
    expense_amount_including_tax = widget.expenses?.expense_amount_including_tax ?? 0;
    expense_date_time_year = widget.expenses?.expense_date_time_year ?? yearValue;
    expense_date_time_month = widget.expenses?.expense_date_time_month ?? monthValue;
    expense_date_time_day = widget.expenses?.expense_date_time_day ?? dayValue;
    expense_memo = widget.expenses?.expense_memo ?? '';
    expense_created_at = widget.expenses?.expense_created_at ?? DateTime.now();
    expense_updated_at = widget.expenses?.expense_updated_at ?? DateTime.now();
    _year_selected = widget.expenses?.expense_date_time_year ?? yearValue;
    _month_selected = widget.expenses?.expense_date_time_month ?? monthValue;
    _day_selected = widget.expenses?.expense_date_time_day ?? dayValue;
    _category_selected = widget.expenses?.expense_category_code ?? '1';
    _payment_selected = widget.expenses?.payment_method_id ?? '1';
  }

// Dropdownの値の変更を行う
  void _onChangedYear(int? value) {
    setState(() {
      _year_selected = value!;
      expense_date_time_year = _year_selected;
    });
  }

  void _onChangedMonth(int? value) {
    setState(() {
      _month_selected = value!;
      expense_date_time_month = _month_selected;
    });
  }

  void _onChangedDay(int? value) {
    setState(() {
      _day_selected = value!;
      expense_date_time_day = _day_selected;
    });
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

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
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
                                            onChanged: (value) {
                                              setState(() {
                                                which = value;
                                              });
                                            },
                                             ),
                                         const Text('通常', style: TextStyle(fontSize: 25),),
                                          Radio(
                                            value: '後払い',
                                            groupValue: which,
                                            onChanged: (value) {
                                              setState(() {
                                                which = value;
                                              });
                                            },
                                             ),
                                          const Text('後払い', style: TextStyle(fontSize: 25),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width:280,
                                      child: Center(
                                            child: TextFormField(
                                              initialValue: expense_amount_including_tax.toString(), style: const TextStyle(fontSize: 35),
                                              textAlign: TextAlign.right,
                                              keyboardType: TextInputType.number,
                                              onChanged: (expense_including_tax) => setState(() => this.expense_amount_including_tax = expense_including_tax.toString() as int)
                                            ),
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
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
                                                const SizedBox(width: 20,),
                                                Container(
                                                  width: 65,
                                                  child: DropdownButton<int>(
                                                    items: _years.map<DropdownMenuItem<int>>((int value) {
                                                      return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value.toString()),
                                                      );
                                                    }).toList(),
                                                    value: _year_selected,
                                                    onChanged: _onChangedYear,
                                                  ),
                                                ),
                                                const Text('年', style: TextStyle(fontSize: 20),),
                                                const SizedBox(width: 20,),
                                                Container(
                                                  width: 45,
                                                  child: DropdownButton<int>(
                                                    items: _months.map<DropdownMenuItem<int>>((int value) {
                                                      return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value.toString()),
                                                      );
                                                    }).toList(),
                                                    value: _month_selected,
                                                    onChanged: _onChangedMonth,
                                                  ),
                                                ),
                                                const Text('月', style: TextStyle(fontSize: 20),),
                                                const SizedBox(width: 20,),
                                                Container(
                                                  width: 45,
                                                  child: DropdownButton<int>(
                                                    items: _days.map<DropdownMenuItem<int>>((int value) {
                                                      return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value.toString()),
                                                      );
                                                    }).toList(),
                                                    value: _day_selected,
                                                    onChanged: _onChangedDay,
                                                  ),
                                                ),
                                                const Text('日', style: TextStyle(fontSize: 20),),
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
                                        border: Border(
                                          bottom: BorderSide(),
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          DropdownButton(
                                            items: [
                                              const DropdownMenuItem(child: Text('支出カテゴリの選択', style: TextStyle(fontSize: 24),),
                                                value: '支出カテゴリの選択',
                                              ),
                                              const DropdownMenuItem(child: Text('食品',style: TextStyle(fontSize: 24),),
                                                value: '食品',
                                              ),
                                            ] ,
                                            onChanged: (String? value) {
                                              setState(() {
                                                expenseSelectedItem = value;
                                              });
                                            },
                                            value: expenseSelectedItem,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Container(
                                      width: 220,

                                      child: Row(
                                        children: <Widget>[
                                          DropdownButton(
                                            items: [
                                              const DropdownMenuItem(child: Text('支払方法を選択', style: TextStyle(fontSize: 24),),
                                                value: '支払方法を選択',
                                              ),
                                              const DropdownMenuItem(child: Text('現金',style: TextStyle(fontSize: 24),),
                                                value: '現金',
                                              ),
                                              const DropdownMenuItem(child: Text('クレジットカード', style: TextStyle(fontSize: 24,),),
                                                value: 'クレジットカード',
                                              ),
                                              const DropdownMenuItem(child: Text('電子マネー', style: TextStyle(fontSize: 24),),
                                                value: '電子マネー',
                                              ),
                                            ] ,
                                            onChanged: (String? value) {
                                              setState(() {
                                                paymentMethodItem = value;
                                              });
                                            },
                                            value: paymentMethodItem,
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
                                                width: 65,
                                                child: DropdownButton<int>(
                                                  isExpanded: true,
                                                  style: const TextStyle(fontSize: 18, color: Colors.black),
                                                  value: yearValue,
                                                  onChanged: (int? value) {
                                                    setState(() {
                                                      yearValue = value!;
                                                    });
                                                  },
                                                  items: _years.map<DropdownMenuItem<int>>((int value) {
                                                    return DropdownMenuItem<int>(
                                                      value: value,
                                                      child: Text('$value'),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              const Text('年', style: TextStyle(fontSize: 20),),
                                              const SizedBox(width: 20,),
                                              Container(
                                                width: 45,
                                                child:  DropdownButton<int>(
                                                  isExpanded: true,
                                                  style: const TextStyle(fontSize: 15, color: Colors.black),
                                                  value: monthValue,
                                                  onChanged: (int? value) {
                                                    setState(() {
                                                      monthValue = value!;
                                                    });
                                                  },
                                                  items: _months.map<DropdownMenuItem<int>>((int value) {
                                                    return DropdownMenuItem<int>(
                                                      value: value,
                                                      child: Text('$value'),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              const Text('月', style: TextStyle(fontSize: 20),),
                                              const SizedBox(width: 20,),
                                              Container(
                                                width: 45,
                                                child:  DropdownButton<int>(
                                                  isExpanded: true,
                                                  style: const TextStyle(fontSize: 15, color: Colors.black),
                                                  value: dayValue,
                                                  onChanged: (int? value) {
                                                    setState(() {
                                                      dayValue = value!;
                                                    });
                                                  },
                                                  items: _days.map<DropdownMenuItem<int>>((int value) {
                                                    return DropdownMenuItem<int>(
                                                      value: value,
                                                      child: Text('$value'),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              const Text('日', style: TextStyle(fontSize: 20),),
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
      expense_consumption_tax: expense_consumption_tax,
      expense_amount_including_tax: expense_amount_including_tax,
      expense_date_time_year: expense_date_time_year,
      expense_date_time_month: expense_date_time_month,
      expense_date_time_day: expense_date_time_day,
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
      expense_consumption_tax: expense_consumption_tax,
      expense_amount_including_tax: expense_amount_including_tax,
      expense_date_time_year: expense_date_time_year,
      expense_date_time_month: expense_date_time_month,
      expense_date_time_day: expense_date_time_day,
      expense_memo: expense_memo,
      expense_created_at: expense_created_at,
      expense_updated_at: expense_updated_at,
    );
    await ExpenseDbHelper.expenseinstance.expenseinsert(expense);        // catの内容で追加する
  }

}


 */