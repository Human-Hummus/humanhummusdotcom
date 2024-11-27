import time, os, subprocess, sys, random

cpath = os.path.dirname(os.path.abspath(__file__)) + "/"
print("current path: " + cpath)

songs = [
            ["Dark Moon OST E. Gadd's Theme.opus", "Luigi's Mansion Dark Moon OST - E. Gadd's Theme"],
            ["OST E. Gadd's Theme.opus", "Luigi's Mansion OST - E. Gadd's Theme"],
            ["Nyan Cat.opus", "Nyan Cat"],
            ["FNaF2 Song.opus", "The Living Toumbstone - Five Nights at Freddy's 2 Song"],
            ["I Can Swing My Sword.opus", "Tobuscus - I Can Swing My Sword"],
            ["gangnam style.opus", "PSY - Gangnam Style"],
            ["coffin dance.opus", "Vicetone & Tony Igy - Astronomia (Coffin Dance)"],
            ["gasgasgas.opus", "Manuel - Gas Gas Gas"],
            ["unity.opus", "TheFatRat - Unity"],
            ["number1.opus", "Lazy Town - We Are Number One"],
            ["imyours.opus", "Breakbot - Baby I'm Yours"],
            ["sfd.opus", "Song for Denise (Maxi Version) (Putin Walk)"],
            ["bbb.opus", "Boom, Boom, Boom!! x Creeper Rap"],
        ]

def update_cl():
    with open("changelog.js", 'w') as file:
        quotes = []
        tmp_quotes = open("quotes.txt", "r").read().split("\n")
        for i in tmp_quotes:
            if i != "":
                quotes.append(i)


        quote = random.choice(quotes)
        song = random.choice(songs)
        print("Chosen Quote: " + quote)
        print("Chosen Song: " + song[1])
        file.write(
                "document.getElementById(\"change_log\").innerHTML = `<div style=\"border-color:black;border-width:2px;border-style:solid;\">" 
                + os.popen("git log --pretty=format:'<li><a style=\"color:cyan;text-decoration-thickness:0.1px;font-size:125%;\" href=\"https://github.com/Human-Hummus/humanhummusdotcom/commit/%H\">%ar - %s</a></li>' -20").read()
                + "</div>"
                +"`;\n"
                + "document.getElementById(\"quote_of_the_hour\").innerHTML = `Quote of the hour:<br />\"" 
                + quote 
                + "\"<br><br>"
                +"Song of the hour: "+ song[1] + "<br><audio src=\"`+ path_to_root+ `assets/music/" + song[0] + "\" controls/>`;"
                )


print(sys.argv)
if len(sys.argv)>1 and sys.argv[1] == "cl":
    update_cl()
    subprocess.call(["make", "build"])
    exit(0)
while True:
    os.chdir("/humanhummusdotcom")
    #subprocess.call(["git", "fetch", "--all"])
    #subprocess.call(["git", "reset", "--hard"])
    subprocess.call(["git", "pull"])
    update_cl()
    subprocess.call(["make", "build"])
    time.sleep((60**2) * 1) # 1 hours



