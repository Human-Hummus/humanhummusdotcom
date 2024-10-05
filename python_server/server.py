from flask import Flask, request, send_file, render_template
from io import BytesIO
import random, string, subprocess, os, sys
from email.utils import parseaddr
from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
import smtplib
from email.mime.text import MIMEText
import subprocess


app = Flask(__name__)

smtp_server = "smtp.gmail.com"
email_port = 587
email_addr = "drungy@humanhummus.com"
email_pass = ""



#def generate_paragraph():
#    output=""
#    for i in range(0,random.randint(1,6)):
#        output+=generate_sentence()

def generate_message():
    return "lol"
    #return "Drungy says: " + generate_paragraph()


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

@app.route("/drungy_letter", methods=["POST"])
def drungy_letter():
    try:
        name = "anon"
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
            print(e)
            os.system("cp /humanhummusdotcom/python_server/drungy_selfie.webp /tmp/ds.webp")
            pic = "/tmp/ds.webp"
        try:
            name = request.form["name"]
        except:
            pass

        email = request.form["email"]
        if not ('@' in parseaddr(email)[1]):
            raise NameError("Invalid e-mail address!")
        
        message = MIMEMultipart()
        message.attach(MIMEText(generate_message(), "plain"))
        part = MIMEApplication(open(pic, "rb").read(), Name="Selfie.webp")
        part['Content-Disposition'] = f'attachment; filename="Selfie.webp"'
        message.attach(part)
        message["Subject"] = "Drungy's message"
        message["From"] = email_addr
        message["To"] = email
        with smtplib.SMTP(smtp_server, email_port) as server:
            server.starttls()
            server.login(email_addr, email_pass)
            server.sendmail(email_addr, email, message.as_string())
            
        return "<script>history.back()</script>"
    except Exception as e:
        return f"Drungy couldn't send your message because \"{e}\"."

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
