import 'package:it_can_cook/src/models/weekly/recipe.dart';

class Order {
  final String userId;
  final String standerdWeeklyPlanId;
  final String note;
  final String address;
  // "longitude": 0,
  //"latitude": 0,

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
      required this.totalPrice,
      required this.recipeList});

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'standerdWeeklyPlanId': standerdWeeklyPlanId,
      'note': note,
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
      'totalPrice': totalPrice,
      'recipeList': recipeList.map((e) => e.toJson()).toList(),
    };
  }
}
