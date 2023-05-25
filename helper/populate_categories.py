# connect to firebase and ask user for input to populate database

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("service-recipe-app.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

while True:
    # ask user for input
    name = input("name: ")
    url = input("url: ")
    description = input("description: ")


    # create a dictionary to store the data
    data = {
        "name": name,
        "thumbnail_url": url,
        "description": description,
        "receipes": []
    }

    # add the data to the database
    db.collection("categories").add(data)
    print("Added data to database")
