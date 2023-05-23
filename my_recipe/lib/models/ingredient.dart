class Ingredient {
  String name;
  String quantity;
  String unit;
  String iconUrl;

  Ingredient(
      {required this.name,
      required this.quantity,
      required this.unit,
      this.iconUrl =
          'https://firebasestorage.googleapis.com/v0/b/recipe-app-6d61d.appspot.com/o/ingredients%2Fvegetable-bucket.png?alt=media&token=a0768a42-aff0-437b-a63b-cc0cd1ce5988'});
}
