import 'package:it_can_cook/src/models/weekly/recipe.dart';

class WeeklyPlan {
  String? id;
  DateTime? beginDate;
  DateTime? endDate;
  String? description;
  String? urlImage;
  String? title;
  DateTime? createAt;
  String? createdBy;
  DateTime? approvedAt;
  String? approvedBy;
  DateTime? updatedAt;
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
      beginDate:
          json['beginDate'] != null ? DateTime.parse(json['beginDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      description: json['description'],
      title: json['title'],
      urlImage: json['urlImage'],
      totalPrice: json['totalPrice'] != null
          ? double.parse(json['totalPrice'].toString())
          : null,
      createAt:
          json['createAt'] != null ? DateTime.parse(json['createAt']) : null,
      createdBy: json['createdBy'],
      approvedAt: json['approvedAt'] != null
          ? DateTime.parse(json['approvedAt'])
          : null,
      approvedBy: json['approvedBy'],
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
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
      'beginDate': beginDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'description': description,
      'title': title,
      'urlImage': urlImage,
      'totalPrice': totalPrice,
      'createAt': createAt?.toIso8601String(),
      'createdBy': createdBy,
      'approvedAt': approvedAt?.toIso8601String(),
      'approvedBy': approvedBy,
      'updatedAt': updatedAt?.toIso8601String(),
      'updatedBy': updatedBy,
      'processStatus': processStatus,
      'recipePLans': recipePlans.map((e) => e.toJson()).toList(),
    };
  }

  //copy with

  WeeklyPlan copyWith({
    String? id,
    DateTime? beginDate,
    DateTime? endDate,
    String? description,
    String? title,
    String? urlImage,
    DateTime? createAt,
    String? createdBy,
    DateTime? approvedAt,
    double? totalPrice,
    String? approvedBy,
    DateTime? updatedAt,
    String? updatedBy,
    String? processStatus,
    List<RecipePlan>? recipePlans,
  }) {
    return WeeklyPlan(
      id: id ?? this.id,
      beginDate: beginDate ?? this.beginDate,
      endDate: endDate ?? this.endDate,
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
