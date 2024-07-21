from flask import Flask, request, send_file, render_template
from io import BytesIO
import random, string, subprocess, os, sys

app = Flask(__name__)

@app.route("/drungy_letter", methods=["POST"])
def drungy_letter():
    pass

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
