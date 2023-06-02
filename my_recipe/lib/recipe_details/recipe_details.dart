import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_recipe/models/food.dart';
import 'package:my_recipe/recipe_details/cooking_method.dart';
import 'package:my_recipe/user.dart';

class RecipeDetails extends StatefulWidget {
  final Food food;

  const RecipeDetails({Key? key, required this.food}) : super(key: key);

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  List<String> ids = [];
  String thisRecipeId = "";

  String id = currentId;

  bool _isMounted = false;
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();

    _isMounted = true;
    displayDetails();
  }

  @override
  void dispose() {
    _isMounted = false;

    if (isFavourite) {
      addToFav();
    } else if (!isFavourite) {
      removeFromFav();
    }

    super.dispose();
  }

  Future<void> addToFav() async {
    DocumentReference<Map<String, dynamic>> userRef =
        FirebaseFirestore.instance.collection('users').doc(id);

    await userRef.update({
      'favourites': FieldValue.arrayUnion([thisRecipeId])
    });
  }

  Future<void> removeFromFav() async {
    DocumentReference<Map<String, dynamic>> userRef =
        FirebaseFirestore.instance.collection('users').doc(id);

    await userRef.update({
      'favourites': FieldValue.arrayRemove([thisRecipeId])
    });
  }

  Future<List<String>> getIdList(String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      final List<dynamic>? favouriteIds =
          userSnapshot.data()!['favourites'] as List<dynamic>?;

      if (favouriteIds != null) {
        return favouriteIds.cast<String>();
      }
    }
    return [];
  }

  void checkFavorites(List<String> favorites) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('recipes').get();

    for (final DocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      final String recipeId = doc.id;
      final String recipeName = doc.data()?['name'] ?? '';

      if (recipeName == widget.food.name) {
        thisRecipeId = recipeId;
      }

      if (favorites.contains(recipeId) && recipeName == widget.food.name) {
        setState(() {
          if (_isMounted) {
            isFavourite = true;
          }
        });
        break;
      }
    }
  }

  Future<void> displayDetails() async {
    ids = await getIdList(id);
    checkFavorites(ids);
  }

  void toggleFavourite() {
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: toggleFavourite,
          ),
        ],
      ),
      body: detailsBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: cookingSteps(context),
    );
  }

  Widget cookingSteps(BuildContext context) {
    return SizedBox(
      width: 200,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CookingMethod(food: widget.food),
            ),
          );
        },
        child: const Text(
          'Start Cooking',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget detailsBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            widget.food.thumbnailUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200.0,
          ),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: (Colors.grey[200])!),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Calories",
                        style: GoogleFonts.roboto(color: Colors.grey),
                      ),
                      Text(
                        "${widget.food.calories} Kcal",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: (Colors.grey[200])!),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Ingredients",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "06",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: (Colors.grey[200])!),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Time",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        widget.food.cookingTime,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: [
                Text(
                  "Ingredients",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.food.ingredientList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        widget
                                            .food.ingredientList[index].iconUrl,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  widget.food.ingredientList[index].name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Text(
                              "${widget.food.ingredientList[index].quantity} ${widget.food.ingredientList[index].unit}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Cooking Method",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam gravida mauris ut semper posuere. Fusce volutpat neque non elementum rutrum. Phasellus et lacus et lacus accumsan commodo ac quis felis. Proin quam lorem, pellentesque in pretium ac, convallis et massa. Donec in nisi magna. In rutrum, nibh id interdum auctor, nisl elit ultricies arcu, ut ullamcorper ipsum mauris quis eros. Aenean ex tortor, pretium eu vulputate a, consectetur vel diam. Cras nulla nisl, euismod eu purus ac, sagittis viverra elit. Duis pulvinar sem quis fermentum iaculis. Quisque pharetra turpis velit, ut hendrerit tortor finibus id. Sed eu pretium libero.Vestibulum semper justo eu purus suscipit scelerisque. Proin eget rhoncus ex. Nam eget egestas nisi. Morbi molestie imperdiet sapien, ut ornare est laoreet in. Nam fermentum venenatis lorem, et scelerisque ante fermentum eget. Vestibulum eget urna ullamcorper, consequat odio et, efficitur arcu. Ut molestie feugiat tristique. Ut lectus erat, malesuada eget elit et, laoreet commodo augue. Nullam at velit vel ipsum tristique rhoncus. Fusce euismod facilisis lorem nec consequat. Donec in turpis tellus. Nunc at massa et sapien hendrerit volutpat. Curabitur condimentum, nibh hendrerit fermentum suscipit, justo lacus pellentesque felis, vitae rhoncus mi est sit amet massa. Donec id hendrerit felis, at blandit ex. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
