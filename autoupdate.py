import time, os, subprocess
while True:
    #os.chdir("/humanhummusdotcom")
    subprocess.call(["git", "pull", "--log", "--stat", "--force"])
    with open("changelog.js", 'w') as file:
        file.write("document.getElementById(\"change_log\").innerHTML = `" + os.popen("git log --pretty=format:'<li>%ar - %s</li>' -20").read() + "`;")
    time.sleep((60**2) * 4) # 4 hours
