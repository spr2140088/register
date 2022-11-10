import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

List<int>years = <int>[2020,2021,2022,2023,2024];

List<int>months = <int>[1,2,3,4,5,6,7,8,9,10,11,12];

List<int>days = <int>[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31];

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
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String? which = '通常';

  int yearValue = years.first;

  int monthValue = months.first;

  int dayValue = days.first;

  String? expenseSelectedItem = '支出カテゴリの選択';

  String? paymentMethodItem = '支払方法を選択';

  String? incomeItem = '収入カテゴリの選択';

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              iconTheme: const IconThemeData(
                  size: 50  //アイコンの大きさ
              ),

              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),

              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {},
                ),
              ],
            ),

            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,children: <Widget>[
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
                          child: TabBarView(children: <Widget>[
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
                                              initialValue: '¥0', style: const TextStyle(fontSize: 35),
                                              textAlign: TextAlign.right,
                                              keyboardType: TextInputType.number,
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
                                                    isExpanded: true,
                                                    style: const TextStyle(fontSize: 18, color: Colors.black),
                                                    value: yearValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        yearValue = value!;
                                                      });
                                                    },
                                                    items: years.map<DropdownMenuItem<int>>((int value) {
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
                                                    style: const TextStyle(fontSize: 18, color: Colors.black),
                                                    value: monthValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        monthValue = value!;
                                                      });
                                                    },
                                                    items: months.map<DropdownMenuItem<int>>((int value) {
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
                                                    style: const TextStyle(fontSize: 18, color: Colors.black),
                                                    value: dayValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        dayValue = value!;
                                                      });
                                                    },
                                                    items: days.map<DropdownMenuItem<int>>((int value) {
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
                                              const DropdownMenuItem(child: Text('aaa',style: TextStyle(fontSize: 24),),
                                                value: 'aaa',
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
                                      decoration: const  BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(),
                                        ),
                                      ),
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
                                        onPressed: () {
                                          showCupertinoDialog(context: context, builder: (context) {
                                            return CupertinoAlertDialog(
                                              title: const Text('登録完了'),
                                              content: const Text('登録完了しました。\n続けて登録しますか？'),
                                              actions: [
                                                CupertinoDialogAction(
                                                  isDestructiveAction: true,
                                                  child: const Text('ホームに戻る'),
                                                  onPressed: () { Navigator.pop(context);},
                                                ),
                                                CupertinoDialogAction(
                                                  child: const Text('続ける'),
                                                  onPressed: () {Navigator.pop(context);},
                                                ),
                                              ],
                                            );
                                          },);
                                        },
                                      ),
                                    ),
                                        ],
                                      ),
                                    ),
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
                                                  items: years.map<DropdownMenuItem<int>>((int value) {
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
                                                  items: months.map<DropdownMenuItem<int>>((int value) {
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
                                                  items: days.map<DropdownMenuItem<int>>((int value) {
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
                                      onPressed: () {
                                        showCupertinoDialog(context: context, builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: const Text('登録完了'),
                                            content: const Text('登録完了しました。\n続けて登録しますか？'),
                                            actions: [
                                              CupertinoDialogAction(
                                                  isDestructiveAction: true,
                                                  child: const Text('ホームに戻る'),
                                                  onPressed: () { Navigator.pop(context);},
                                              ),
                                              CupertinoDialogAction(
                                                child: const Text('続ける'),
                                                onPressed: () {Navigator.pop(context);},
                                              ),
                                            ],
                                          );
                                        },);
                                      },
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
  }
}
