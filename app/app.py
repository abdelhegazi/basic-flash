from flask import Flask
from flask import request


#app = Flask(__name__)
iso_code = {"UK": "GB", "Spain":"ES", "Ireland":"IE", "France":"FR"}
app = Flask(__name__)


@app.route("/api/v1/countries")
def hello():
    # return "Hello World!"
    return iso_code[request.args.get('name')]
if __name__ == '__main__':
    app.run(debug=True)