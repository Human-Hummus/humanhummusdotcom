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


dirf = os.path.dirname(os.path.abspath(__file__)) + "/"
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
        stuff = subprocess.run(["python", dirf +"drungy_speak/main.py", request.form["text"], dirf+"../tmp/speech.ogg", request.form["speed"]], stdout=subprocess.PIPE).stdout.decode('utf-8').replace("\n","<br>")
        print(stuff)
        return open(dirf + "drungy_speak.html", "r").read().replace("--TEXT--", stuff).replace("--AUDIO--", "<audio controls src=\"tmp/speech.ogg?random_number="+str(random.randint(0,99999999))+"\"></audio>")
        
    else:
        return open( dirf + "drungy_speak.html", "r").read().replace("--AUDIO--", "").replace("--TEXT--", "")

@app.route("/chatbox", methods=["POST", "GET"])
def chatbox():
    if request.method == "POST":
        name = "anon"
        try:
            if request.form["name"] != "":name = request.form["name"]
        except:pass

        stuff = subprocess.run([dirf + "chat_main/executable", "write", name+ ": " +request.form["text"]], stdout=subprocess.PIPE).stdout.decode('utf-8').replace("\n","<br>")
        return "<meta http-equiv=\"Refresh\" content=\"0; url='https://www.humanhummus.com'\" />";
        
    else:
        return subprocess.run([dirf + "chat_main/executable"], stdout=subprocess.PIPE).stdout.decode('utf-8').replace("\n","<br>")


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

            
            for line in subprocess.run([dirf + 'drungy_selfie/executable', tmp_if], stdout=subprocess.PIPE).stdout.decode('utf-8').split("\n"):
                if "FINAL:/tmp/" in line:
                    pic = line.split(":")[1]
                    print(pic)
            

            os.system("rm \"" + tmp_if + "\"")
        except Exception as e:
            print("error")
            print(e)
        text = subprocess.run(['python', dirf + 'main.py', 'read', dirf+'6e.h5', 'run', "Dear "+ name+","], stdout=subprocess.PIPE).stdout.decode('utf-8').split("---BEGIN---")[1]
        if pic =="":
            os.system("cp "+dirf+"drungy_selfie.webp /tmp/ds.webp")
            pic = "/tmp/ds.webp"
        print(pic) 

        return "<html><head><title>Drungy's Letter</title></head><body><img style=\"width:50%;\"src=\"data:image/webp;base64," + base64.b64encode(open(pic, "rb").read()).decode("ascii")+"\" /><p>" + text + "</p></body></html>"
    except Exception as e:
        return f"Drungy couldn't send your message because \"{e}\"."

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")


