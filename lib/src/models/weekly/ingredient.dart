class Ingredient {
  String? id;
  String? ingredientCategoryId;
  String? name;
  String? pakagingMethod;
  String? img;
  String? unit;
  double? price;
  String? status;
  DateTime? createdAt;
  String? createdBy;
  DateTime? updatedAt;
  String? updatedBy;
  IngredientNutrient? ingredientNutrient;
  IngredientCategory? ingredientCategory;

  Ingredient({
    this.id,
    this.ingredientCategoryId,
    this.name,
    this.img,
    this.unit,
    this.price,
    this.pakagingMethod,
    this.status,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.ingredientNutrient,
    this.ingredientCategory,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      ingredientCategoryId: json['ingredientCategoryId'],
      name: json['name'],
      pakagingMethod: json['pakagingMethod'],
      img: json['img'],
      unit: json['unit'],
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : null,
      status: json['status'],
      createdAt:
          json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      createdBy: json['createdBy'],
      updatedAt:
          json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
      updatedBy: json['updatedBy'],
      ingredientNutrient: json['ingredientNutrient'] == null
          ? null
          : IngredientNutrient.fromJson(json['ingredientNutrient']),
      ingredientCategory: json['ingredientCategory'] == null
          ? null
          : IngredientCategory.fromJson(json['ingredientCategory']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ingredientCategoryId': ingredientCategoryId,
      'name': name,
      'img': img,
      'unit': unit,
      'pakagingMethod': pakagingMethod,
      'price': price,
      'status': status,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
      'ingredientNutrient': ingredientNutrient?.toJson(),
      'ingredientCategory': ingredientCategory?.toJson(),
    };
  }
}

class IngredientCategory {
  String? id;
  String? name;
  String? description;
  String? status;

  IngredientCategory({
    this.id,
    this.name,
    this.description,
    this.status,
  });

  factory IngredientCategory.fromJson(Map<String, dynamic> json) {
    return IngredientCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
    };
  }
}

class IngredientNutrient {
  String? id;
  String? ingredientID;
  double? calories;
  double? fat;
  double? saturatedFat;
  double? sugar;
  double? carbonhydrate;
  double? dietaryFiber;
  double? protein;
  double? sodium;

  IngredientNutrient({
    this.id,
    this.ingredientID,
    this.calories,
    this.fat,
    this.saturatedFat,
    this.sugar,
    this.carbonhydrate,
    this.dietaryFiber,
    this.protein,
    this.sodium,
  });

  factory IngredientNutrient.fromJson(Map<String, dynamic> json) {
    return IngredientNutrient(
      id: json['id'],
      ingredientID: json['ingredientID'],
      calories: json['calories'] != null
          ? double.parse(json['calories'].toString())
          : null,
      fat: json['fat'] != null ? double.parse(json['fat'].toString()) : null,
      saturatedFat: json['saturatedFat'] != null
          ? double.parse(json['saturatedFat'].toString())
          : null,
      sugar:
          json['sugar'] != null ? double.parse(json['sugar'].toString()) : null,
      carbonhydrate: json['carbonhydrate'] != null
          ? double.parse(json['carbonhydrate'].toString())
          : null,
      dietaryFiber: json['dietaryFiber'] != null
          ? double.parse(json['dietaryFiber'].toString())
          : null,
      protein: json['protein'] != null
          ? double.parse(json['protein'].toString())
          : null,
      sodium: json['sodium'] != null
          ? double.parse(json['sodium'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ingredientID': ingredientID,
      'calories': calories,
      'fat': fat,
      'saturatedFat': saturatedFat,
      'sugar': sugar,
      'carbonhydrate': carbonhydrate,
      'dietaryFiber': dietaryFiber,
      'protein': protein,
      'sodium': sodium,
    };
  }
}
