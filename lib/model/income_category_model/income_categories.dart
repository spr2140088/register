import 'package:e_i_register/model/income_category_model/income_category_db_helper.dart';
import 'package:intl/intl.dart';

class Incomecategories {
  int income_category_code;
  String income_category_name;
  DateTime income_category_created_at;
  DateTime income_category_updated_at;

  Incomecategories({
    required this.income_category_code,
    required this.income_category_name,
    required this.income_category_created_at,
    required this.income_category_updated_at,
  });

// 更新時のデータを入力項目からコピーする処理
  Incomecategories copy({
    int? income_category_code,
    String? income_category_name,
    DateTime? income_category_created_at,
    DateTime? income_category_updated_at,
  }) =>
      Incomecategories(
        income_category_code: income_category_code ?? this.income_category_code,
        income_category_name: income_category_name ?? this.income_category_name,
        income_category_created_at: income_category_created_at ?? this.income_category_created_at,
        income_category_updated_at: income_category_updated_at ?? this.income_category_updated_at,
      );

  static Incomecategories fromJson(Map<String, Object?> json) => Incomecategories(
    income_category_code: json[columnIncomeCategoryCode] as int,
    income_category_name: json[columnIncomeCategoryName] as String,
    income_category_created_at: DateTime.parse(json[columnIncomeCategoryCreatedAt] as String),
    income_category_updated_at: DateTime.parse(json[columnIncomeCategoryUpdatedAt] as String),
  );

  Map<String, Object> toJson() => {
    columnIncomeCategoryCode: income_category_code,
    columnIncomeCategoryName: income_category_name,
    columnIncomeCategoryCreatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(income_category_created_at),
    columnIncomeCategoryUpdatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(income_category_updated_at),
  };
}