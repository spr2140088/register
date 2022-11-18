import 'package:e_i_register/view/expense_view/expense_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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