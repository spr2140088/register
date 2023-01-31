import 'package:e_i_register/model/payment_method_model/payment_method_db_helper.dart';
import 'package:intl/intl.dart';

class PaymentMethods {
  int payment_method_id;
  String payment_method_name;
  DateTime payment_method_created_at;
  DateTime payment_method_updated_at;

  PaymentMethods({
    required this.payment_method_id,
    required this.payment_method_name,
    required this.payment_method_created_at,
    required this.payment_method_updated_at,
  });

// 更新時のデータを入力項目からコピーする処理
  PaymentMethods copy({
    int? payment_method_id,
    String? payment_method_name,
    DateTime? payment_method_created_at,
    DateTime? payment_method_updated_at,
  }) =>
      PaymentMethods(
          payment_method_id: payment_method_id ?? this.payment_method_id,
          payment_method_name: payment_method_name ?? this.payment_method_name,
          payment_method_created_at: payment_method_created_at ?? this.payment_method_created_at,
          payment_method_updated_at: payment_method_updated_at ?? this.payment_method_updated_at
      );

  static PaymentMethods fromJson(Map<String, Object?> json) => PaymentMethods(
    payment_method_id: json[columnPaymentMethodId] as int,
    payment_method_name: json[columnPaymentMethodName] as String,
    payment_method_created_at: DateTime.parse(json[columnPaymentMethodCreatedAt] as String),
    payment_method_updated_at: DateTime.parse(json[columnPaymentMethodUpdatedAt] as String),
  );

  Map<String, Object> toJson() => {
    columnPaymentMethodId: payment_method_id,
    columnPaymentMethodName: payment_method_name,
    columnPaymentMethodCreatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(payment_method_created_at),
    columnPaymentMethodUpdatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(payment_method_updated_at),
  };
}