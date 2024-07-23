from flask import Flask, request, send_file, render_template
from io import BytesIO
import random, string, subprocess, os, sys
from email.utils import parseaddr
import smtplib
from email.mime.text import MIMEText


app = Flask(__name__)

smtp_server = "smtp.gmail.com"
email_port = 587
email_addr = "drungy@humanhummus.com"
email_pass = ""

def generate_message():
    return "UwU"


for line in open("/super-secret.txt", "r").read().split("\n"):
    if ":" in line:
        action=line.split(":")[0].strip()
        content=line.split(":")[1].strip()
        if "app-pass" == action:
            email_pass = content

@app.route("/drungy_letter", methods=["POST"])
def drungy_letter():
    try:
        email = request.form["email"]
        if not ('@' in parseaddr(email)[1]):
            raise NameError("Invalid e-mail address!")
        message = MIMEText(generate_message(), "plain")
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
