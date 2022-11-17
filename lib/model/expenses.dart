import 'package:e_i_register/model/expense_db_helper.dart';
import 'package:intl/intl.dart';

// catsテーブルの定義
class Expenses {
  int? expense_id;
  String expense_category_code;
  String expense_genre_code;
  String payment_method_id;
  int? expense_total_money;
  int? expense_consumption_tax;
  int expense_amount_including_tax;
  DateTime expense_datetime;
  String expense_memo;
  DateTime expense_created_at;
  DateTime expense_updated_at;

  Expenses({
    this.expense_id,
    required this.expense_category_code,
    required this.expense_genre_code,
    required this.payment_method_id,
    this.expense_total_money,
    this.expense_consumption_tax,
    required this.expense_amount_including_tax,
    required this.expense_datetime,
    required this.expense_memo,
    required this.expense_created_at,
    required this.expense_updated_at,
  });

// 更新時のデータを入力項目からコピーする処理
  Expenses copy({
    int? expense_id,
    String? expense_category_code,
    String? expense_genre_code,
    String? payment_method_id,
    int? expnse_total_money,
    int? expense_consumption_tax,
    int? expense_amount_including_tax,
    DateTime? expense_datetime,
    String? expense_memo,
    DateTime? expense_created_at,
    DateTime? expense_updated_at,
  }) =>
      Expenses(
        expense_id: expense_id ?? this.expense_id,
        expense_category_code: expense_category_code ?? this.expense_category_code,
        expense_genre_code: expense_genre_code ?? this.expense_genre_code,
        payment_method_id: payment_method_id ?? this.payment_method_id,
        expense_total_money: expense_total_money ?? this.expense_total_money,
        expense_consumption_tax: expense_consumption_tax ?? this.expense_consumption_tax,
        expense_amount_including_tax: expense_amount_including_tax ?? this.expense_amount_including_tax,
        expense_datetime: expense_datetime ?? this.expense_datetime,
        expense_memo: expense_memo ?? this.expense_memo,
        expense_created_at: expense_created_at ?? this.expense_created_at,
        expense_updated_at: expense_updated_at ?? this.expense_updated_at,
      );

  static Expenses fromJson(Map<String, Object?> json) => Expenses(
    expense_id: json[columnExpenseId] as int,
    expense_category_code: json[columnExpenseCategoryCode] as String,
    expense_genre_code: json[columnExpenseGenreCode] as String,
    payment_method_id: json[columnPaymentMethodId] as String,
    expense_total_money: json[columnExpenseTotalMoney] as int,
    expense_consumption_tax: json[columnExpenseConsumptionTax] as int,
    expense_amount_including_tax: json[columnExpenseAmountIncludingTax] as int,
    expense_datetime: DateTime.parse(json[columnExpenseDateTime] as String),
    expense_memo: json[columnExpenseMemo] as String,
    expense_created_at: DateTime.parse(json[columnExpenseCreatedAt] as String),
    expense_updated_at: DateTime.parse(json[columnExpenseUpdatedAt] as String),
  );

  Map<String, Object> toJson() => {
    columnExpenseCategoryCode: expense_category_code,
    columnExpenseGenreCode: expense_genre_code,
    columnPaymentMethodId: payment_method_id,
    columnExpenseDateTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(expense_datetime),
    columnExpenseMemo: expense_memo,
    columnExpenseCreatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(expense_created_at),
    columnExpenseUpdatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(expense_updated_at),
  };
}