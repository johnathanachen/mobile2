import server
import unittest
import json
from pymongo import MongoClient

db = None
# this is for a gitpush lol
class FlaskrTestCase(unittest.TestCase):

    def setUp(self):
        self.app = server.app.test_client()

        # Run app in testing mode to retrieve exceptions and stack traces
        server.app.config['TESTING'] = True

        # Inject test database into application
        mongo = MongoClient('localhost', 27017)
        global db
        db = mongo.test_db
        server.app.db = db

        ## We do this to clear our database before each test runs
        db.drop_collection('users')


def test_getting_a_user(self):

    ## Post 2 users to database
    self.app.post('/test_db/',
                      headers=None,
                      data=json.dumps(dict(
                          name="Eliel Gordon",
                          email="eliel@example.com"
                      )),
                      content_type='application/json')

    ## 3 Make a get request to fetch the posted user

    response = self.app.get('/test_db/',
                            query_string=dict(email="eliel@example.com")
                        )

    # Decode reponse
    response_json = json.loads(response.data.decode())

    ## Actual test to see if GET request was succesful
    ## Here we check the status code
    self.assertEqual(response.status_code, 200)
