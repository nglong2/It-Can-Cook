import 'package:it_can_cook/src/models/weekly/ingredient.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';

class OrderHistory {
  String? id;
  String? userId;
  int? orderCode;
  String? receiveName;
  String? receivePhone;
  String? note;
  String? address;
  double? longitude;
  double? latitude;
  String? shipDate;
  String? orderDate;
  double? totalPrice;
  String? status;
  String? img;
  String? orderImg;
  String? orderTitle;
  String? message;
  WeeklyPlan? weeklyPlan;
  Transactions? transaction;
  List<OrderDetails> orderDetails = [];
  FeedBacks? feedBacks;

  OrderHistory({
    this.id,
    this.userId,
    this.receiveName,
    this.receivePhone,
    this.orderCode,
    this.note,
    this.address,
    this.longitude,
    this.latitude,
    this.shipDate,
    this.orderDate,
    this.totalPrice,
    this.status,
    this.img,
    this.message,
    this.weeklyPlan,
    this.orderImg,
    this.orderTitle,
    this.transaction,
    this.orderDetails = const [],
    this.feedBacks,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      id: json['id'],
      userId: json['userId'],
      orderCode: json['orderCode'],
      receiveName: json['receiveName'],
      receivePhone: json['receivePhone'],
      note: json['note'],
      address: json['address'],
      message: json['message'],
      shipDate: json['shipDate'],
      orderDate: json['orderDate'],
      img: json['img'],
      orderImg: json['orderImg'],
      orderTitle: json['orderTitle'],
      longitude: json['longitude'] != null
          ? double.parse(json['longitude'].toString())
          : null,
      latitude: json['latitude'] != null
          ? double.parse(json['latitude'].toString())
          : null,
      totalPrice: json['totalPrice'] != null
          ? double.parse(json['totalPrice'].toString())
          : null,
      status: json['status'],
      weeklyPlan: json['weeklyPlan'] != null
          ? WeeklyPlan.fromJson(json['weeklyPlan'])
          : null,
      transaction: json['transaction'] != null
          ? Transactions.fromJson(json['transaction'])
          : null,
      orderDetails: json['orderDetails'] != null
          ? List<OrderDetails>.from(
              json['orderDetails'].map((x) => OrderDetails.fromJson(x)))
          : [],
      feedBacks: json['feedBacks'] != null
          ? FeedBacks.fromJson(json['feedBacks'])
          : null,
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

class Transactions {
  String? id;
  String? orderId;
  String? type;
  double? amount;
  String? transactionDate;
  String? notice;
  String? extraData;
  String? signature;
  String? status;

  Transactions({
    this.id,
    this.orderId,
    this.type,
    this.amount,
    this.transactionDate,
    this.notice,
    this.extraData,
    this.signature,
    this.status,
  });

  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
      id: json['id'],
      orderId: json['orderId'],
      type: json['type'],
      amount: json['amount'] != null
          ? double.parse(json['amount'].toString())
          : null,
      transactionDate: json['transactionDate'],
      notice: json['notice'],
      extraData: json['extraData'],
      signature: json['signature'],
      status: json['status'],
    );
  }
}

//feedback
// "feedBacks": {
//         "id": "55dc85b8-5ba9-418b-6d2c-08dcd7b21da8",
//         "orderId": "ca995b29-d0ec-42ab-07a1-08dcd726725b",
//         "rating": 2,
//         "description": "test",
//         "createdAt": "2024-09-18T07:18:38.1381454",
//         "createdBy": "string"
//       }
//     }

class FeedBacks {
  String? id;
  String? orderId;
  int? rating;
  String? description;
  String? createdAt;
  String? createdBy;

  FeedBacks({
    this.id,
    this.orderId,
    this.rating,
    this.description,
    this.createdAt,
    this.createdBy,
  });

  factory FeedBacks.fromJson(Map<String, dynamic> json) {
    return FeedBacks(
      id: json['id'],
      orderId: json['orderId'],
      rating: json['rating'],
      description: json['description'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
    );
  }
}
