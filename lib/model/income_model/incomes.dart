// Expensesテーブルの定義
import 'package:intl/intl.dart';

import 'income_db_helper.dart';

class Incomes {
  int income_id;
  int income_category_code;
  int income_money;
  DateTime income_day;
  String income_memo;
  DateTime income_created_at;
  DateTime income_updated_at;

  Incomes({
    required this.income_id,
    required this.income_category_code,
    required this.income_money,
    required this.income_day,
    required this.income_memo,
    required this.income_created_at,
    required this.income_updated_at,
  });

// 更新時のデータを入力項目からコピーする処理
  Incomes copy({
    int? income_id,
    int? income_category_code,
    int? income_money,
    DateTime? income_day,
    String? income_memo,
    DateTime? income_created_at,
    DateTime? income_updated_at,
  }) =>
      Incomes(
        income_id: income_id ?? this.income_id,
        income_category_code: income_category_code ?? this.income_category_code,
        income_money: income_money ?? this.income_money,
        income_day: income_day ?? this.income_day,
        income_memo: income_memo ?? this.income_memo,
        income_created_at: income_created_at ?? this.income_created_at,
        income_updated_at: income_updated_at ?? this.income_updated_at,
      );

  static Incomes fromJson(Map<String, Object?> json) => Incomes(
    income_id: json[columnIncomeId] as int,
    income_category_code: json[columnIncomeCategoryCode] as int,
    income_money: json[columnIncomeMoney] as int,
    income_day: DateTime.parse(json[columnIncomeDay] as String),
    income_memo: json[columnIncomeMemo] as String,
    income_created_at: DateTime.parse(json[columnIncomeCreatedAt] as String),
    income_updated_at: DateTime.parse(json[columnIncomeUpdatedAt] as String),
  );

  Map<String, Object> toJson() => {
    columnIncomeCategoryCode: income_category_code,
    columnIncomeMoney: income_money,
    columnIncomeDay: DateFormat('yyyy-MM-dd HH:mm:ss').format(income_day),
    columnIncomeMemo: income_memo,
    columnIncomeCreatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(income_created_at),
    columnIncomeUpdatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(income_updated_at),
  };
}