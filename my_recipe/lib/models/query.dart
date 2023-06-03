import 'package:cloud_firestore/cloud_firestore.dart';

class Query {
  static List<String> allIngredientList = [];

  void wait() async {
    await fetchIngredientList();
  }

  Future fetchIngredientList() async {
    FirebaseFirestore.instance
        .collection('ingredients')
        .get()
        .then((QuerySnapshot querySnapshot) {
      allIngredientList.clear();
      querySnapshot.docs.forEach((doc) {
        String id = doc.id;
        String name = doc['name'];
        String url = doc['url'];
        allIngredientList.add(id);
        allIngredientList.add(name);
        allIngredientList.add(url);
      });
    });
  }
}
