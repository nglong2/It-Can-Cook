import 'dart:convert';

import 'package:it_can_cook/src/api/rest.dart';
import 'package:it_can_cook/src/models/transactions/transaction.dart';

class TransactionController {
  final RestApi api = RestApi();

//   curl -X 'POST' \
//   'https://api.wemealkit.ddns.net/api/transaction/create-new' \
//   -H 'accept: */*' \
//   -H 'Content-Type: application/json' \
//   -d '{
//   "orderId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//   "transactionType": 0,
//   "amount": 0,
//   "transactionDate": "2024-08-01T01:34:35.671Z",
//   "notice": "string",
//   "extraData": "string",
//   "signature": "string",
//   "status": 0
// }'

  Future<bool> createTransaction(Transaction data) async {
    var value = await api.post("api/transaction/create-new", data.toJson());
    var a = jsonEncode(data.toJson());
    if (value.statusCode == 200) {
      return true;
    }
    return false;
  }
}
