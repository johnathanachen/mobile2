from flask import Flask, request, make_response
from flask_restful import Resource, Api
from pymongo import MongoClient
from utils.mongo_json_encoder import JSONEncoder
from bson.objectid import ObjectId
# import pdb
import bcrypt

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"
