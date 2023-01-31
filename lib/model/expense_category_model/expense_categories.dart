import 'package:intl/intl.dart';

import '../expense_model/expense_db_helper.dart';
import 'expense_category_db_helper.dart';

class Expensecategories {
  int expense_category_code;
  String expense_category_name;
  DateTime expense_category_created_at;
  DateTime expense_category_updated_at;

  Expensecategories({
    required this.expense_category_code,
    required this.expense_category_name,
    required this.expense_category_created_at,
    required this.expense_category_updated_at,
  });

// 更新時のデータを入力項目からコピーする処理
  Expensecategories copy({
    int? expense_category_code,
    String? expense_category_name,
    DateTime? expense_category_created_at,
    DateTime? expense_category_updated_at,
  }) =>
      Expensecategories(
        expense_category_code: expense_category_code ?? this.expense_category_code,
        expense_category_name: expense_category_name ?? this.expense_category_name,
        expense_category_created_at: expense_category_created_at ?? this.expense_category_created_at,
        expense_category_updated_at: expense_category_updated_at ?? this.expense_category_updated_at,
      );

  static Expensecategories fromJson(Map<String, Object?> json) => Expensecategories(
    expense_category_code: json[columnExpenseCategoryCode] as int,
    expense_category_name: json[columnExpenseCategoryName] as String,
    expense_category_created_at: DateTime.parse(json[columnExpenseCategoryCreatedAt] as String),
    expense_category_updated_at: DateTime.parse(json[columnExpenseCategoryUpdatedAt] as String),
  );

  Map<String, Object> toJson() => {
    columnExpenseCategoryCode: expense_category_code,
    columnExpenseCategoryName: expense_category_name,
    columnExpenseCategoryCreatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(expense_category_created_at),
    columnExpenseCategoryUpdatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(expense_category_updated_at),
  };
}