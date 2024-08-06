import 'package:it_can_cook/src/models/weekly/recipe.dart';

class Order {
  final String userId;
  final String standerdWeeklyPlanId;
  final String note;
  final String address;
  final String img;
  // "receiveName": "string",
  // "receivePhone": "string",
  // "longitude": 0,
  //"latitude": 0,
//"transactionType": 0,
  final String receiveName;
  final String receivePhone;
  final int transactionType;

  double longitude;
  double latitude;
  final double totalPrice;
  final List<RecipePlan> recipeList;

  Order(
      {required this.userId,
      required this.standerdWeeklyPlanId,
      required this.note,
      required this.address,
      required this.longitude,
      required this.latitude,
      required this.receiveName,
      required this.receivePhone,
      required this.transactionType,
      required this.totalPrice,
      required this.img,
      required this.recipeList});

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'standerdWeeklyPlanId': standerdWeeklyPlanId,
      'note': note,
      'address': address,
      'longitude': longitude,
      'receiveName': receiveName,
      'receivePhone': receivePhone,
      'transactionType': transactionType,
      'img': img,
      'latitude': latitude,
      'totalPrice': totalPrice,
      'recipeList': recipeList.map((e) => e.toJson()).toList(),
    };
  }

  // fromJson method
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      userId: json['userId'],
      standerdWeeklyPlanId: json['standerdWeeklyPlanId'],
      note: json['note'],
      address: json['address'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      receiveName: json['receiveName'],
      receivePhone: json['receivePhone'],
      transactionType: json['transactionType'],
      totalPrice: json['totalPrice'],
      img: json['img'],
      recipeList: json['recipeList'] != null
          ? List<RecipePlan>.from(
              json['recipeList'].map((x) => RecipePlan.fromJson(x)))
          : [],
    );
  }
}
