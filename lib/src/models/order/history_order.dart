import 'package:it_can_cook/src/models/weekly/ingredient.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';

class OrderHistory {
  String? id;
  String? userId;
  String? note;
  String? address;
  String? shipDate;
  String? orderDate;
  double? totalPrice;
  String? status;
  WeeklyPlan? weeklyPlan;
  List<OrderDetails> orderDetails = [];

  OrderHistory({
    this.id,
    this.userId,
    this.note,
    this.address,
    this.shipDate,
    this.orderDate,
    this.totalPrice,
    this.status,
    this.weeklyPlan,
    this.orderDetails = const [],
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      id: json['id'],
      userId: json['userId'],
      note: json['note'],
      address: json['address'],
      shipDate: json['shipDate'],
      orderDate: json['orderDate'],
      totalPrice: json['totalPrice'] != null
          ? double.parse(json['totalPrice'].toString())
          : null,
      status: json['status'],
      weeklyPlan: json['weeklyPlan'] != null
          ? WeeklyPlan.fromJson(json['weeklyPlan'])
          : null,
      orderDetails: json['orderDetails'] != null
          ? List<OrderDetails>.from(
              json['orderDetails'].map((x) => OrderDetails.fromJson(x)))
          : [],
    );
  }
}

class OrderDetails {
  String? id;
  String? recipeId;
  String? standardWeeklyPlanId;
  int? dayInWeek;
  int? mealInDay;
  int? quantity;
  double? price;
  Recipe? recipe;
  List<RecipeIngredientOrderDetails> recipeIngredientOrderDetails;

  OrderDetails({
    this.id,
    this.recipeId,
    this.standardWeeklyPlanId,
    this.dayInWeek,
    this.mealInDay,
    this.quantity,
    this.price,
    this.recipe,
    this.recipeIngredientOrderDetails = const [],
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['id'],
      recipeId: json['recipeId'],
      standardWeeklyPlanId: json['standardWeeklyPlanId'],
      dayInWeek: json['dayInWeek'],
      mealInDay: json['mealInDay'],
      quantity: json['quantity'],
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : null,
      recipe: json['recipe'] != null ? Recipe.fromJson(json['recipe']) : null,
      recipeIngredientOrderDetails: json['recipeIngredientOrderDetails'] != null
          ? List<RecipeIngredientOrderDetails>.from(
              json['recipeIngredientOrderDetails']
                  .map((x) => RecipeIngredientOrderDetails.fromJson(x)))
          : [],
    );
  }
}
