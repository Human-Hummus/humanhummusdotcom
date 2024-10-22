from flask import Flask, request, send_file, render_template
from io import BytesIO
import random, string, subprocess, os, sys
from email.utils import parseaddr
from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
import smtplib
from email.mime.text import MIMEText
import subprocess
import base64


app = Flask(__name__)

smtp_server = "smtp.gmail.com"
email_port = 587
email_addr = "drungy@humanhummus.com"
email_pass = ""



for line in open("/super-secret.txt", "r").read().split("\n"):
    if ":" in line:
        action=line.split(":")[0].strip()
        content=line.split(":")[1].strip()
        if "app-pass" == action:
            email_pass = content

def random_temp(fex):
    length = 25
    toret = "/tmp/"
    while length > 0:
        length-=1
        toret+=random.choice(string.ascii_letters)
    return toret+"."+fex

@app.route("/drungy_voice", methods=["POST", "GET"])
def drungy_voice():
    if request.method == "POST":
        subprocess.run(["python", "/humanhummus/python_server/drungy_speak/main.py", request.form["text"], "/tmp/speech.mp3"])
        return open("/humanhummusdotcom/python_server/drungy_speak.html", "r").read().replace("--AUDIO--", "<audio src\"data:audio/mp3;base64,"+base64.b64encode(open("/tmp/speech.mp3", "rb").read()).decode("ascii")+ "\">")
        
    else:
        return open("/humanhummusdotcom/python_server/drungy_speak.html", "r").read().replace("--AUDIO--", "")

@app.route("/drungy_letter", methods=["POST"])
def drungy_letter():
    try:
        name = "anon"
        try:name=request.form["name"]
        except:pass
        pic = ""
        try:
            tmp_if = random_temp(request.files["file"].filename.split(".")[len(request.files["file"].filename.split("."))-1])
            with open(tmp_if, "wb") as f:
                f.write(request.files["file"].read())

            print(tmp_if)

            
            for line in subprocess.run(['/humanhummusdotcom/python_server/drungy_selfie/executable', tmp_if], stdout=subprocess.PIPE).stdout.decode('utf-8').split("\n"):
                if "FINAL:/tmp/" in line:
                    pic = line.split(":")[1]
                    print(pic)
            

            os.system("rm \"" + tmp_if + "\"")
        except Exception as e:
            print("error")
            print(e)
        text = subprocess.run(['python', '/humanhummusdotcom/python_server/main.py', 'read', '/humanhummusdotcom/python_server/6e.h5', 'run', "Dear "+ name+","], stdout=subprocess.PIPE).stdout.decode('utf-8').split("---BEGIN---")[1]
        if pic =="":
            os.system("cp /humanhummusdotcom/python_server/drungy_selfie.webp /tmp/ds.webp")
            pic = "/tmp/ds.webp"
        print(pic) 

        return "<html><head><title>Drungy's Letter</title></head><body><img style=\"width:50%;\"src=\"data:image/webp;base64," + base64.b64encode(open(pic, "rb").read()).decode("ascii")+"\" /><p>" + text + "</p></body></html>"
    except Exception as e:
        return f"Drungy couldn't send your message because \"{e}\"."

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")


