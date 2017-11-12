from flask import Flask, request
import json
from pymongo import MongoClient
import pdb

from bson import Binary, Code
from bson.json_util import dumps

from json_encoder import JSONEncoder

app = Flask(__name__)

mongo = MongoClient('localhost', 27017)

app.db = mongo.test

@app.route("/users")
def get_users():
    my_dict_from_json = request.json

    #1 Get Url params
    name = request.args.get('name')

    #2 Our users collection
    users_collection = app.db.users

    #3 Find document in our users collection
    result = users_collection.find_one({'name': name})

    json_representation = dumps(result)

    return(json_representation, 200, None)


    #
    # #4 Convert result to json, its initally a python dict
    # json_result = JSONEncoder.encode(result)

    #5 Return the json as part of the response body
    # return (json_result, 200, None)


if __name__ == '__main__':
    app.config['TRAP_BAD_REQUEST_ERRORS'] = True
    app.run(debug=True)
