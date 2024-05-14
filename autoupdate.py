import time, os, subprocess, sys, random
def update_cl():
    with open("changelog.js", 'w') as file:
        quotes = []
        tmp_quotes = open("quotes.txt", "r").read().split("\n")
        for i in tmp_quotes:
            if i != "":
                quotes.append(i)


        quote = random.choice(quotes)
        print("chosen quote: " + quote)
        file.write(
                "document.getElementById(\"change_log\").innerHTML = `" + os.popen("git log --pretty=format:'<li>%ar - %s</li>' -20").read() + "`;\n"
                + "document.getElementById(\"quote_of_the_hour\").innerHTML = \"Quote of the hour:<br />" + quote + "\";"
                )


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



