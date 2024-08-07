class Refund {
  int? appId;
  String? mRefundId;
  String? zpTransId;
  int? amount;
  int? refundFeeAmount;
  int? timestamp;
  String? description;
  String? mac;

  Refund({
    this.appId,
    this.mRefundId,
    this.zpTransId,
    this.amount,
    this.refundFeeAmount,
    this.timestamp,
    this.description,
    this.mac,
  });

  // Factory constructor to create a Refund instance from a map (JSON)
  factory Refund.fromJson(Map<String, dynamic> json) {
    return Refund(
      appId: json['app_id'],
      mRefundId: json['m_refund_id'],
      zpTransId: json['zp_trans_id'],
      amount: json['amount'],
      refundFeeAmount: json['refund_fee_amount'],
      timestamp: json['timestamp'],
      description: json['description'],
      mac: json['mac'],
    );
  }

  // Method to convert a Refund instance to a map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'app_id': appId,
      'm_refund_id': mRefundId,
      'zp_trans_id': zpTransId,
      'amount': amount,
      'refund_fee_amount': refundFeeAmount,
      'timestamp': timestamp,
      'description': description,
      'mac': mac,
    };
  }
}
