//  {
//       "id": "90b799c0-1e02-4804-6654-08dc84841d24",
//       "name": "Thit kho tung cut",
//       "servingSize": "3",
//       "difficulty": 3,
//       "description": "Thit kho trung huyen thoai ngay Tet",
//       "imageLink": null,
//       "createdAt": "2024-06-04T17:50:13.8921206",
//       "createdBy": "string",
//       "approvedAt": null,
//       "approvedBy": "",
//       "updatedAt": "2024-06-04T17:50:13.8928569",
//       "updatedBy": "",
//       "popularity": 0,
//       "processStatus": 1
//     }

class RecipeModel {
  String? id;
  String? name;
  String? servingSize;
  int? difficulty;
  String? description;
  String? imageLink;
  String? createdAt;
  String? createdBy;
  String? approvedAt;
  String? approvedBy;
  String? updatedAt;
  String? updatedBy;
  int? popularity;
  int? processStatus;

  RecipeModel({
    required this.id,
    required this.name,
    required this.servingSize,
    required this.difficulty,
    required this.description,
    required this.imageLink,
    required this.createdAt,
    required this.createdBy,
    required this.approvedAt,
    required this.approvedBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.popularity,
    required this.processStatus,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      name: json['name'],
      servingSize: json['servingSize'],
      difficulty: json['difficulty'],
      description: json['description'],
      imageLink: json['imageLink'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      approvedAt: json['approvedAt'],
      approvedBy: json['approvedBy'],
      updatedAt: json['updatedAt'],
      updatedBy: json['updatedBy'],
      popularity: json['popularity'],
      processStatus: json['processStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'servingSize': servingSize,
      'difficulty': difficulty,
      'description': description,
      'imageLink': imageLink,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'approvedAt': approvedAt,
      'approvedBy': approvedBy,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
      'popularity': popularity,
      'processStatus': processStatus,
    };
  }
}
