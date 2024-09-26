import 'package:it_can_cook/src/models/weekly/recipe.dart';

class WeeklyPlan {
  String? id;
  String? beginDate;
  String? endDate;
  String? description;
  String? urlImage;
  String? title;
  String? createAt;
  String? createdBy;
  String? approvedAt;
  String? approvedBy;
  String? updatedAt;
  String? updatedBy;
  double? totalPrice;
  String? processStatus;
  List<RecipePlan> recipePlans;

  WeeklyPlan({
    this.id,
    this.beginDate,
    this.endDate,
    this.description,
    this.title,
    this.urlImage,
    this.createAt,
    this.createdBy,
    this.approvedAt,
    this.approvedBy,
    this.updatedAt,
    this.updatedBy,
    this.processStatus,
    this.totalPrice,
    required this.recipePlans,
  });

  factory WeeklyPlan.fromJson(Map<String, dynamic> json) {
    return WeeklyPlan(
      id: json['id'],
      beginDate: json['beginDate'],
      endDate: json['endDate'],
      description: json['description'],
      title: json['title'],
      urlImage: json['urlImage'],
      totalPrice: json['totalPrice'] != null
          ? double.parse(json['totalPrice'].toString())
          : null,
      createAt: json['createAt'],
      createdBy: json['createdBy'],
      approvedAt: json['approvedAt'],
      approvedBy: json['approvedBy'],
      updatedAt: json['updatedAt'],
      updatedBy: json['updatedBy'],
      processStatus: json['processStatus'],
      recipePlans: json['recipePLans'] == null
          ? []
          : (json['recipePLans'] as List)
              .map((e) => RecipePlan.fromJson(e))
              .toList(),
    );
  }

  //to json

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'beginDate': beginDate,
      'endDate': endDate,
      'description': description,
      'title': title,
      'urlImage': urlImage,
      'totalPrice': totalPrice,
      'createAt': createAt,
      'createdBy': createdBy,
      'approvedAt': approvedAt,
      'approvedBy': approvedBy,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
      'processStatus': processStatus,
      'recipePLans': recipePlans.map((e) => e.toJson()).toList(),
    };
  }

//to Json Create
  Map<String, dynamic> toJsonCreate() {
    return {
      'id': id,
      'weeklyPlanId': id,
      'beginDate': DateTime.now().toIso8601String(),
      'endDate': DateTime.now().toIso8601String(),
      'description': description,
      'title': title,
      'urlImage': urlImage,
      'totalPrice': totalPrice,
      'createAt': createAt,
      'createdBy': createdBy,
      'approvedAt': approvedAt,
      'approvedBy': approvedBy,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
      'processStatus': 3,
      'recipeIds': recipePlans.map((e) => e.toJson()).toList(),
    };
  }
  //copy with

  WeeklyPlan copyWith({
    String? id,
    String? beginDate,
    String? endDate,
    String? description,
    String? title,
    String? urlImage,
    String? createAt,
    String? createdBy,
    String? approvedAt,
    double? totalPrice,
    String? approvedBy,
    String? updatedAt,
    String? updatedBy,
    String? processStatus,
    List<RecipePlan>? recipePlans,
  }) {
    return WeeklyPlan(
      id: id ?? this.id,
      beginDate: DateTime.now().toIso8601String(),
      endDate: DateTime.now().toIso8601String(),
      description: description ?? this.description,
      title: title ?? this.title,
      urlImage: urlImage ?? this.urlImage,
      createAt: createAt ?? this.createAt,
      createdBy: createdBy ?? this.createdBy,
      totalPrice: totalPrice ?? this.totalPrice,
      approvedAt: approvedAt ?? this.approvedAt,
      approvedBy: approvedBy ?? this.approvedBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      processStatus: processStatus ?? this.processStatus,
      recipePlans: recipePlans ?? this.recipePlans,
    );
  }
}
