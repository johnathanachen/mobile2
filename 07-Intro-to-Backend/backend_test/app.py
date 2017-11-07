from flask import Flask, request
import json
import pdb

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/users')
def get_users():
    person = {"name": "Johnathan", "age": "1million"}
    json_person = json.dumps(person)
    # pdb.set_trace()
    return(json_person, 200, None)

@app.route('/my_page')
def somefunc():
    return "my page text"

@app.route('/pets', methods = ["GET", "POST"])
def pets():
    if request.method == "GET":
        pet = {"name": "Buddy", "age": 1}
        json_pet = json.dumps(pet)
        return(json_pet, 200, None)
    if request.method == "POST":
        pet = {"name": "Buddy", "age": 2}
        json_pet = json.dumps(pet)
        return(json_pet, 200, None)

if __name__ == '__main__':
    app.run()
    app.config["DEBUG"] = True
