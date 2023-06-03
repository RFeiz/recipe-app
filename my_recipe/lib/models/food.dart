// food structure
import 'package:my_recipe/models/method.dart';

import 'package:my_recipe/models/query.dart';
import 'package:my_recipe/models/ingredient.dart';

class Food {
  String name;
  String smallDescription;
  String longDescription;
  String thumbnailUrl;

  List<Ingredient> ingredientList;
  List<Method> methodList;

  String cookingTime;
  int calories;
  //int servings;

  int likes;

  Food(
      {required this.name,
      required this.smallDescription,
      required this.longDescription,
      required this.thumbnailUrl,
      required this.cookingTime,
      required this.calories,
      //required this.servings,
      required this.likes,
      required this.ingredientList,
      required this.methodList});

  static Food convertToFood(Map<String, dynamic> data) {
    String defaultIcon =
        "https://firebasestorage.googleapis.com/v0/b/recipe-app-6d61d.appspot.com/o/ingredients%2Fvegetable-bucket.png?alt=media&token=a0768a42-aff0-437b-a63b-cc0cd1ce5988";
    List<Ingredient> ingredientList = [];
    List<String> tempIngredientList = [];
    tempIngredientList = Query.allIngredientList;

    Map<String, dynamic> ingredientsData = data['ingredient_list'];
    ingredientsData.forEach((id, ingredientData) {
      String unit = ingredientData['unit'];
      String quantity = ingredientData['quantity'].toString();

      for (int i = 0; i <= tempIngredientList.length; i++) {
        if (tempIngredientList[i] == id) {
          if (tempIngredientList[i + 2] == "") {
            Ingredient ingredient = Ingredient(
                name: tempIngredientList[i + 1],
                unit: unit,
                quantity: quantity,
                iconUrl: defaultIcon);
            ingredientList.add(ingredient);
          } else {
            Ingredient ingredient = Ingredient(
                name: tempIngredientList[i + 1],
                unit: unit,
                quantity: quantity,
                iconUrl: tempIngredientList[i + 2]);
            ingredientList.add(ingredient);
          }
          break;
        }
      }
    });

    String name = data['name'];
    String smallDescription = data['small_description'];
    String longDescription = data['long_description'];
    String thumbnailUrl = data['thumbnail_url'];
    String cookingTime = data['cooking_time'];
    int calories = data['calories'];
    int likes = data['likes'];

    return Food(
      name: name,
      smallDescription: smallDescription,
      longDescription: longDescription,
      thumbnailUrl: thumbnailUrl,
      cookingTime: cookingTime,
      calories: calories,
      likes: likes,
      ingredientList: ingredientList,
      methodList:
          Method.convertToMethod(data['method']), // implement later @feiz
    );
  }
}
