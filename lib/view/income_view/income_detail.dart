import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/income_model/income_db_helper.dart';
import '../../model/income_model/incomes.dart';
import '../expense_view/expense_detail_edit.dart';

class IncomeDetail extends StatefulWidget {
  final int id;

  const IncomeDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<IncomeDetail> createState() => _IncomeDetailState();
}

class _IncomeDetailState extends State<IncomeDetail> {
  late Incomes incomes;
  bool isLoading = false;
  static const int textExpandedFlex = 1; // 見出しのexpaded flexの比率
  static const int dataExpandedFlex = 4; // 項目のexpanede flexの比率


// Stateのサブクラスを作成し、initStateをオーバーライドすると、wedgit作成時に処理を動かすことができる。
// ここでは、渡されたidをキーとしてcatsテーブルからデータを取得する
  @override
  void initState() {
    super.initState();
    incomeData();
  }

// initStateで動かす処理
// catsテーブルから指定されたidのデータを1件取得する
  Future incomeData() async {
    setState(() => isLoading = true);
    incomes = await IncomeDbHelper.incomeinstance.incomeData(widget.id);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('支出詳細'),
          actions: [
            IconButton(
              onPressed: () async {                          // 鉛筆のアイコンが押されたときの処理を設定
                await Navigator.of(context).push(            // ページ遷移をNavigatorで設定
                  MaterialPageRoute(
                    builder: (context) => ExpenseDetailEdit(    // 詳細更新画面を表示する
                      incomes: incomes,
                    ),
                  ),
                );
                incomeData();                                  // 更新後のデータを読み込む
              },
              icon: const Icon(Icons.edit),                 // 鉛筆マークのアイコンを表示
            ),
            IconButton(
              onPressed: () async {                         // ゴミ箱のアイコンが押されたときの処理を設定
                await IncomeDbHelper.incomeinstance.incomedelete(widget.id);  // 指定されたidのデータを削除する
                Navigator.of(context).pop();                // 削除後に前の画面に戻る
              },
              icon: const Icon(Icons.delete),               // ゴミ箱マークのアイコンを表示
            )
          ],
        ),
        body: isLoading                                     //「読み込み中」だったら「グルグル」が表示される
            ? const Center(
          child: CircularProgressIndicator(),         // これが「グルグル」の処理
        )
            : Column(
          children :[
            Column(                                             // 縦並びで項目を表示
              crossAxisAlignment: CrossAxisAlignment.stretch,   // 子要素の高さを合わせる
              children: [
                Row(children: [
                  const Expanded(                               // 見出しの設定
                    flex: textExpandedFlex,
                    child: Text('日付',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: dataExpandedFlex,
                    child: Container(                           // catsテーブルのnameの表示を設定
                      padding: const EdgeInsets.all(5.0),
                      child: Text(DateFormat("yyyy年MM月dd日").format(incomes.income_day)),
                    ),
                  ),
                ],),
                Row(children: [
                  const Expanded(     // 「メモ」の見出し行の設定
                      flex: textExpandedFlex,
                      child: Text('税込み金額',
                        textAlign: TextAlign.center,
                      )
                  ),
                  Expanded(
                    flex: dataExpandedFlex,
                    child: Container(                                      // catsテーブルのmemoの表示を設定
                      padding: const EdgeInsets.all(5.0),
                      child: Text(incomes.income_money.toString()),
                    ),
                  ),
                ],),
                Row(children: [
                  const Expanded(           // 「誕生日」の見出し行の設定
                    flex: textExpandedFlex,
                    child: Text('カテゴリー',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: dataExpandedFlex,
                    child: Container(                                      // catsテーブルのbirthdayの表示を設定
                      padding: const EdgeInsets.all(5.0),
                      child: Text(incomes.income_category_code),
                    ),
                  )
                ],),
                Row(children: [
                  const Expanded(     // 「メモ」の見出し行の設定
                      flex: textExpandedFlex,
                      child: Text('メモ',
                        textAlign: TextAlign.center,
                      )
                  ),
                  Expanded(
                    flex: dataExpandedFlex,
                    child: Container(                                      // catsテーブルのmemoの表示を設定
                      padding: const EdgeInsets.all(5.0),
                      child: Text(incomes.income_memo),
                    ),
                  ),
                ],),
              ],
            ),
          ],
        )
    );
  }
}