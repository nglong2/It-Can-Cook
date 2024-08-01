class Transaction {
  String orderId;
  int transactionType;
  int amount;
  String transactionDate;
  String notice;
  String extraData;
  String signature;
  int status;

  Transaction({
    required this.orderId,
    required this.transactionType,
    required this.amount,
    required this.transactionDate,
    required this.notice,
    required this.extraData,
    required this.signature,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      orderId: json['orderId'],
      transactionType: json['transactionType'],
      amount: json['amount'],
      transactionDate: json['transactionDate'],
      notice: json['notice'],
      extraData: json['extraData'],
      signature: json['signature'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'transactionType': transactionType,
      'amount': amount,
      'transactionDate': DateTime.parse(transactionDate).toIso8601String(),
      'notice': notice,
      'extraData': extraData,
      'signature': signature,
      'status': status,
    };
  }
}
