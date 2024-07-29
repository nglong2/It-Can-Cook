class Ingredient {
  String? id;
  String? ingredientCategoryId;
  String? name;
  String? packagingMethod;
  String? preservationMethod;
  String? img;
  String? unit;
  double? price;
  String? status;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
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
    this.packagingMethod,
    this.preservationMethod,
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
      packagingMethod: json['packagingMethod'],
      preservationMethod: json['preservationMethod'],
      img: json['img'],
      unit: json['unit'],
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : null,
      status: json['status'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      updatedAt: json['updatedAt'],
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
      'packagingMethod': packagingMethod,
      'preservationMethod': preservationMethod,
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

// "recipeIngredientOrderDetails": [
//             {
//               "id": "1d170a90-02a4-429b-76a4-08dcabe9c0b1",
//               "orderDetailId": "e92be3a4-478c-4f3d-fe11-08dcabe9bee9",
//               "recipeId": "14bcddde-fd02-4edc-30e9-08dca869b2da",
//               "ingredientId": "420cfe59-5fc6-40e8-994a-08dca7ec0554",
//               "amount": 0.02,
//               "ingredientPrice": 800,
//               "ingredient": {
//                 "id": "420cfe59-5fc6-40e8-994a-08dca7ec0554",
//                 "ingredientCategoryId": "4b019598-dbc7-46ae-b620-08dc9781cfc6",
//                 "name": "Hành Lá",
//                 "img": "https://wemealkit.s3.amazonaws.com/51hành lá raw.jpg",
//                 "unit": "kg",
//                 "price": 20000,
//                 "packagingMethod": "Túi nhựa theo từng bó",
//                 "preservationMethod": "Bọc trong giấy báo hoặc khăn giấy ẩm, sau đó cho vào túi zip và để trong ngăn mát tủ lạnh.; Lưu ý: Tránh để hành lá bị ẩm quá nhiều vì dễ bị thối.",
//                 "status": "Available",
//                 "createdAt": "2024-07-19T12:14:33.9320473",
//                 "createdBy": "BA21D44E-75FF-4039-8ADA-C494C0A90FC9",
//                 "updatedAt": "2024-07-19T12:14:33.9320476",
//                 "updatedBy": "BA21D44E-75FF-4039-8ADA-C494C0A90FC9",
//                 "ingredientNutrient": null,
//                 "ingredientCategory": null
//               }
//             }
//           ]
//         },

class RecipeIngredientOrderDetails {
  String? id;
  String? orderDetailId;
  String? recipeId;
  String? ingredientId;
  double? amount;
  double? ingredientPrice;
  Ingredient? ingredient;

  RecipeIngredientOrderDetails({
    this.id,
    this.orderDetailId,
    this.recipeId,
    this.ingredientId,
    this.amount,
    this.ingredientPrice,
    this.ingredient,
  });

  factory RecipeIngredientOrderDetails.fromJson(Map<String, dynamic> json) {
    return RecipeIngredientOrderDetails(
      id: json['id'],
      orderDetailId: json['orderDetailId'],
      recipeId: json['recipeId'],
      ingredientId: json['ingredientId'],
      amount: json['amount'] != null
          ? double.parse(json['amount'].toString())
          : null,
      ingredientPrice: json['ingredientPrice'] != null
          ? double.parse(json['ingredientPrice'].toString())
          : null,
      ingredient: json['ingredient'] == null
          ? null
          : Ingredient.fromJson(json['ingredient']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderDetailId': orderDetailId,
      'recipeId': recipeId,
      'ingredientId': ingredientId,
      'amount': amount,
      'ingredientPrice': ingredientPrice,
      'ingredient': ingredient?.toJson(),
    };
  }
}
