import 'package:it_can_cook/src/models/weekly/ingredient.dart';

class RecipeIngredient {
  String? id;
  String? recipeId;
  String? ingredientId;
  double? amount;
  Ingredient? ingredient;

  RecipeIngredient({
    this.id,
    this.recipeId,
    this.ingredientId,
    this.amount,
    this.ingredient,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeIngredient(
      id: json['id'],
      recipeId: json['recipeId'],
      ingredientId: json['ingredientId'],
      amount: json['amount'] != null
          ? double.parse(json['amount'].toString())
          : null,
      ingredient: json['ingredient'] != null
          ? Ingredient.fromJson(json['ingredient'])
          : null,
    );
  }
  // tojson

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipeId': recipeId,
      'ingredientId': ingredientId,
      'amount': amount,
      'ingredient': ingredient?.toJson(),
    };
  }
}

class RecipeCategory {
  String? id;
  String? categoryId;
  String? recipeId;
  Category? category;

  RecipeCategory({
    this.id,
    this.categoryId,
    this.recipeId,
    this.category,
  });

  factory RecipeCategory.fromJson(Map<String, dynamic> json) {
    return RecipeCategory(
      id: json['id'],
      categoryId: json['categoryId'],
      recipeId: json['recipeId'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'recipeId': recipeId,
      'category': category?.toJson(),
    };
  }
}

class RecipeNutrient {
  String? id;
  String? recipeID;
  double? calories;
  double? fat;
  double? saturatedFat;
  double? sugar;
  double? carbonhydrate;
  double? dietaryFiber;
  double? protein;
  double? sodium;

  RecipeNutrient({
    this.id,
    this.recipeID,
    this.calories,
    this.fat,
    this.saturatedFat,
    this.sugar,
    this.carbonhydrate,
    this.dietaryFiber,
    this.protein,
    this.sodium,
  });

  factory RecipeNutrient.fromJson(Map<String, dynamic> json) {
    return RecipeNutrient(
      id: json['id'],
      recipeID: json['recipeID'],
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

  // tojson

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipeID': recipeID,
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

class RecipeStep {
  String? id;
  String? recipeId;
  int? index;
  String? mediaURL;
  String? imageLink;
  String? description;

  RecipeStep({
    this.id,
    this.recipeId,
    this.index,
    this.mediaURL,
    this.imageLink,
    this.description,
  });

  factory RecipeStep.fromJson(Map<String, dynamic> json) {
    return RecipeStep(
      id: json['id'],
      recipeId: json['recipeId'],
      index: json['index'],
      mediaURL: json['mediaURL'],
      imageLink: json['imageLink'],
      description: json['description'],
    );
  }

  // tojson

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipeId': recipeId,
      'index': index,
      'mediaURL': mediaURL,
      'imageLink': imageLink,
      'description': description,
    };
  }
}

class Recipe {
  String? id;
  String? name;
  int? servingSize;
  int? cookingTime;
  String? difficulty;
  String? description;
  String? notice;
  String? img;
  double? price;
  int? popularity;
  String? processStatus;
  String? baseStatus;
  String? createdAt;
  String? createdBy;
  String? approvedAt;
  String? approvedBy;
  String? updatedAt;
  String? updatedBy;
  List<RecipeIngredient> recipeIngredients = [];
  List<RecipeCategory> recipeCategories = [];
  RecipeNutrient? recipeNutrient;
  List<RecipeStep> recipeSteps = [];

  Recipe({
    this.id,
    this.name,
    this.servingSize,
    this.difficulty,
    this.cookingTime,
    this.description,
    this.baseStatus,
    this.notice,
    this.img,
    this.price,
    this.popularity,
    this.processStatus,
    this.createdAt,
    this.createdBy,
    this.approvedAt,
    this.approvedBy,
    this.updatedAt,
    this.updatedBy,
    this.recipeIngredients = const [],
    this.recipeCategories = const [],
    this.recipeNutrient,
    this.recipeSteps = const [],
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      servingSize: json['servingSize'],
      difficulty: json['difficulty'],
      cookingTime: json['cookingTime'],
      baseStatus: json['baseStatus'],
      description: json['description'],
      notice: json['notice'],
      img: json['img'],
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : null,
      popularity: json['popularity'],
      processStatus: json['processStatus'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      approvedAt: json['approvedAt'],
      approvedBy: json['approvedBy'],
      updatedAt: json['updatedAt'],
      updatedBy: json['updatedBy'],
      recipeIngredients: json['recipeIngredients'] == null
          ? []
          : (json['recipeIngredients'] as List)
              .map((e) => RecipeIngredient.fromJson(e))
              .toList(),
      recipeCategories: json['recipeCategories'] == null
          ? []
          : (json['recipeCategories'] as List)
              .map((e) => RecipeCategory.fromJson(e))
              .toList(),
      recipeNutrient: json['recipeNutrient'] == null
          ? null
          : RecipeNutrient.fromJson(json['recipeNutrient']),
      recipeSteps: json['recipeSteps'] == null
          ? []
          : (json['recipeSteps'] as List)
              .map((e) => RecipeStep.fromJson(e))
              .toList(),
    );
  }

  // tojson

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'servingSize': servingSize,
      'cookingTime': cookingTime,
      'difficulty': difficulty,
      'description': description,
      'baseStatus': baseStatus,
      'notice': notice,
      'img': img,
      'price': price,
      'popularity': popularity,
      'processStatus': processStatus,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'approvedAt': approvedAt,
      'approvedBy': approvedBy,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
      'recipeIngredients': recipeIngredients.map((e) => e.toJson()).toList(),
      'recipeCategories': recipeCategories.map((e) => e.toJson()).toList(),
      'recipeNutrient': recipeNutrient?.toJson(),
      'recipeSteps': recipeSteps.map((e) => e.toJson()).toList(),
    };
  }
}

class RecipePlan {
  String? id;
  String? recipeId;
  String? standardWeeklyPlanId;
  int? quantity;
  int? numberPerson;
  double? price;
  Recipe? recipe;
  int? dayInWeek;
  int? mealInDay;
  String? weeklyPlanId;

  RecipePlan({
    this.id,
    this.recipeId,
    this.standardWeeklyPlanId,
    this.quantity,
    this.price,
    this.recipe,
    this.dayInWeek,
    this.mealInDay,
    this.numberPerson,
    this.weeklyPlanId,
  });

  factory RecipePlan.fromJson(Map<String, dynamic> json) {
    return RecipePlan(
      id: json['id'],
      recipeId: json['recipeId'],
      standardWeeklyPlanId: json['standardWeeklyPlanId'],
      quantity: json['quantity'],
      dayInWeek: json['dayInWeek'],
      mealInDay: json['mealInDay'],
      numberPerson: json['numberPerson'],
      weeklyPlanId: json['weeklyPlanId'],
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : null,
      recipe: json['recipe'] != null ? Recipe.fromJson(json['recipe']) : null,
    );
  }

  // tojson

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipeId': recipeId,
      'standardWeeklyPlanId': standardWeeklyPlanId,
      'quantity': quantity,
      'dayInWeek': dayInWeek,
      'mealInDay': mealInDay,
      'price': price,
      'numberPerson': numberPerson,
      'weeklyPlanId': weeklyPlanId,
      'recipe': recipe?.toJson(),
    };
  }
  // copywith

  RecipePlan copyWith({
    String? id,
    String? recipeId,
    String? standardWeeklyPlanId,
    int? quantity,
    double? price,
    Recipe? recipe,
    int? dayInWeek,
    int? mealInDay,
    int? numberPerson,
    String? weeklyPlanId,
  }) {
    return RecipePlan(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      standardWeeklyPlanId: standardWeeklyPlanId ?? this.standardWeeklyPlanId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      recipe: recipe ?? this.recipe,
      dayInWeek: dayInWeek ?? this.dayInWeek,
      mealInDay: mealInDay ?? this.mealInDay,
      numberPerson: numberPerson ?? this.numberPerson,
      weeklyPlanId: weeklyPlanId ?? this.weeklyPlanId,
    );
  }
}

class Category {
  //  "type": "Nation",
  //                 "name": "VN",
  //                 "description": "VN"
  String? type;
  String? name;
  String? description;

  Category({
    this.type,
    this.name,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      type: json['type'],
      name: json['name'],
      description: json['description'],
    );
  }

  // tojson

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'description': description,
    };
  }
}
