# connect to firebase and ask user for input to populate database

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("service-recipe-app.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

#  Food(
#       name: "Pasta with Tomato Sauce",
#       smallDescription:
#           "A delicious pasta with tomato sauce and cheese topping.",
#       longDescription:
#           "A delicious pasta with tomato sauce and cheese topping.",
#       thumbnailUrl:
#           "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
#       cookingTime: "30m",
#       calories: 596,
#       likes: 5,
#       ingredientList: [
#         Ingredient(name: "Pasta", quantity: "200", unit: "g"),
#         Ingredient(name: "Tomato", quantity: "2", unit: "pcs"),
#         Ingredient(name: "Cheese", quantity: "100", unit: "g"),
#       ],
#     ),

# method = [{time:0, description:"", title:""}, {time:0, description:"", title:""}]

while True:

    # ask user for input
    name = input("name: ")
    smallDescription = input("smallDescription: ")
    longDescription = input("longDescription: ")
    thumbnailUrl = input("thumbnailUrl: ")
    cookingTime = input("cookingTime: ")
    calories = input("calories: ")
    likes = input("likes: ")
    
    flag = True
    ingredientList = {}
    while flag == True:
        print("Enter ingredientList")
        ingredientName= input("name: ")
        # search for the id of the ingredient
        ingredientId = db.collection("ingredients").where("name", "==", ingredientName).get()
        if len(ingredientId) == 0:
            print("Ingredient not found")
            continue
    
        ingredientQuantity = input("quantity: ")
        ingredientUnit = input("unit: ")
        ingredientList[ingredientId[0].id] = {
            "quantity": int(ingredientQuantity),
            "unit": ingredientUnit
        }

        x = input("Add another ingredient? (y/n): ")
        if x == "y":
            flag = True
        else:
            flag = False

    flag = True
    methods = []
    while flag == True:
        print("Enter method")
        methodTitle = input("title: ")
        methodDescription = input("description: ")
        methodTime = input("time: ")
        methods.append({
            "title": methodTitle,
            "description": methodDescription,
            "time": int(methodTime)
        })

        x = input("Add another method? (y/n): ")
        if x == "y":
            flag = True
        else:
            flag = False    

    # create a dictionary to store the data
    data = {
        "name": name,
        "small_description": smallDescription,
        "long_description": longDescription,
        "thumbnail_url": thumbnailUrl,
        "cooking_time": cookingTime,
        "calories": int(calories),
        "likes": int(likes),
        "ingredient_list": ingredientList,
        "method": methods
    }
    
    # add the data to the database
    db.collection("recipes").add(data)
    print("Added data to database")
    print("______________________________")

