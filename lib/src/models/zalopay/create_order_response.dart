class CreateOrderResponse {
  final String zptranstoken;
  final String orderurl;
  final int returncode;
  final String returnmessage;
  final int subreturncode;
  final String subreturnmessage;
  final String ordertoken;
  final String transid;

  CreateOrderResponse(
      {required this.zptranstoken,
      required this.orderurl,
      required this.returncode,
      required this.returnmessage,
      required this.subreturncode,
      required this.subreturnmessage,
      required this.ordertoken,
      required this.transid});

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponse(
        zptranstoken: json['zp_trans_token'] as String,
        orderurl: json['order_url'] as String,
        returncode: json['return_code'] as int,
        returnmessage: json['return_message'] as String,
        subreturncode: json['sub_return_code'] as int,
        subreturnmessage: json['sub_return_message'] as String,
        ordertoken: json["order_token"] as String,
        transid: json["transid"] as String);
  }
}
