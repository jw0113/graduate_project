from flask import Flask, request
import urllib.request


app = Flask(__name__)

@app.route("/flasktest", methods = ['GET', 'POST'])
def flasktest():
    if(request.method == 'GET'):
        header = request.headers.get("Content-Type")
        f = request.files['file']
        print(f)
        print(header)
        return "response {} ".format(f)

if __name__ == '__main__':
    app.run(debug=False, host="127.0.0.1",port=5000)