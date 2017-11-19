from flask import Flask, request, make_response
from flask_restful import Api, Resource
from pymongo import MongoClient

from encoder import JSONEncoder

import pdb
import json

mongo = MongoClient('localhost', 27017)

app = Flask(__name__)
api = Api(app)

app.db = mongo.test


class User(Resource):
    def post(self):
        new_user = request.json

        users_collection = app.db.users

        result = users_collection.insert_one(new_user)

        return "User {} was added yuuuh".format(result.inserted_id)

    def get(self):
        """Get list of users."""
        users_collection = app.db.users

        name = request.args.get("name")

        response = users_collection.find_one({"name": name})


        return response

    def delete(self):
        name = request.args.get("name")

        users_collection = app.db.users

        response = users_collection.delete_one({"name": name})

        return "{} was deleted yuuuh".format(name)

    def put(self):
        name = request.args.get("name")

        users_collection = app.db.users

        response = users_collection.find_one_and_replace({"name": name}, {"name": "gucci mane"})

        return "{} was replaced yuuuh".format(name)


api.add_resource(User, '/users')

@api.representation('application/json')
def output_json(data, code, headers=None):
    resp = make_response(JSONEncoder().encode(data), code)
    resp.headers.extend(headers or {})
    return resp


if __name__ == "__main__":
    app.run(debug=True)
