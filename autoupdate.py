import time, os, subprocess, sys
def update_cl():
    with open("changelog.js", 'w') as file:
        file.write("document.getElementById(\"change_log\").innerHTML = `" + os.popen("git log --pretty=format:'<li>%ar - %s</li>' -20").read() + "`;")



print(sys.argv)
if len(sys.argv)>1 and sys.argv[1] == "cl":
    update_cl()
    exit(0)
while True:
    os.chdir("/humanhummusdotcom")
    subprocess.call(["git", "fetch", "--all"])
    subprocess.call(["git", "reset", "--hard"])
    update_cl()
    time.sleep((60**2) * 4) # 4 hours



