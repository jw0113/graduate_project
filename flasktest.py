from flask import Flask
import urllib.request

app = Flask(__name__)

@app.route("/flasktest")
def flasktest():
    return "flasktest"

if __name__ == '__main__':
    app.run(debug=False, host="127.0.0.1",port=5000)