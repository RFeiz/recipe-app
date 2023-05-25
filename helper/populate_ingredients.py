# connect to firebase and ask user for input to populate database

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("service-recipe-app.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

while True:
    # ask user for input
    print("Enter name, icon url")
    name = input("name: ")
    url = input("url (can leave empty): ")

    # create a dictionary to store the data
    data = {
        "name": name,
        "url": url
    }

    # add the data to the database
    db.collection("ingredients").add(data)
    print("Added data to database")
