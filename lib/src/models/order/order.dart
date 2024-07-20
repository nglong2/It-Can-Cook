import 'package:it_can_cook/src/models/weekly/recipe.dart';

class Order {
  final String userId;
  final String standerdWeeklyPlanId;
  final String note;
  final String address;
  final double totalPrice;
  final List<RecipePlan> recipeList;

  Order(
      {required this.userId,
      required this.standerdWeeklyPlanId,
      required this.note,
      required this.address,
      required this.totalPrice,
      required this.recipeList});

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'standerdWeeklyPlanId': standerdWeeklyPlanId,
      'note': note,
      'address': address,
      'totalPrice': totalPrice,
      'recipeList': recipeList.map((e) => e.toJson()).toList(),
    };
  }
}
