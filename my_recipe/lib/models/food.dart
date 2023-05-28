// food structure
import 'ingredient.dart';

class Food {
  String name;
  String smallDescription;
  String longDescription;
  String thumbnailUrl;

  List<Ingredient> ingredientList;

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
      required this.ingredientList});

  static Food convertToFood(Map<String, dynamic> data) {
    List<Ingredient> ingredientList = [];

    Map<String, dynamic> ingredientsData = data['ingredient_list'];
    ingredientsData.forEach((id, ingredientData) {
      String unit = ingredientData['unit'];
      String quantity = ingredientData['quantity'].toString();
      Ingredient ingredient =
          Ingredient(unit: unit, quantity: quantity, name: '');
      ingredientList.add(ingredient);
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
    );
  }
}
