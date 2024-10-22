
import subprocess, os, sys


inp = sys.argv[1]
out = sys.argv[2]

ipa = subprocess.run(["espeak", inp, "-v", "en-us", "--ipa", '-q'], capture_output=True).stdout.decode("utf-8")

dirf = "/humanhummusdotcom/python_server/drungy_speak/sounds/"

sounds = [
        ["tʃ", "tʃ.wav"],
        ["dʒ", "dʒ.wav"],
        ["oʊ", "oʊ.wav"],
        ["o", "oʊ.wav"],
        ["aɪ", "aɪ.wav"],
        ["aʊ", "aʊ.wav"],
        ["ɔɪ", "ɔɪ.wav"],

        ["p", "p.wav"],
        ["d", "d.wav"],
        ["b", "b.wav"],
        ["t", "t.wav"],
        ["ɾ", "t.wav"],
        ["k", "k.wav"],
        ["ɡ", "ɡ.wav"],
        ["m", "m.wav"],
        ["n", "n.wav"],
        ["ŋ", "ŋ.wav"],
        ["f", "f.wav"],
        ["v", "v.wav"],
        ["θ", "θ.wav"],
        ["ð", "ð.wav"],
        ["s", "s.wav"],
        ["z", "z.wav"],
        ["ʃ", "ʃ.wav"],
        ["ʒ", "ʒ.wav"],
        ["h", "h.wav"],
        ["w", "w.wav"],
        ["j", "j.wav"],
        ["r", "r.wav"],
        ["ɹ", "r.wav"],
        ["ɚ", "r.wav"],
        ["l", "l.wav"],
        ["i", "i.wav"],
        ["ɪ", "ɪ.wav"],
        ["e", "e.wav"],
        ["ɛ", "ɛ.wav"],
        ["æ", "æ.wav"],
        ["a", "æ.wav"],
        ["ʌ", "ʌ.wav"],
        ["ə", "ə.wav"],
        ["u", "u.wav"],
        ["ʊ", "ʊ.wav"],
        ["ɔ", "ɔ.wav"],
        ["ɒ", "ɑ.wav"],
        ["ɑ", "ɑ.wav"],
        ["x", "x.wav"],
        [" ", "none.wav"],
        #["ˈ", "none.wav"],
        ["\n", "none.wav"],
        ["ɐ", "ə.wav"],
        ]

files = ""

x = 0
ipa="#"+ipa+"#"
while x < len(ipa):
    found_sound = False
    for s in sounds:
        if ipa[x]!="#" and len(s[0]) > 1 and s[0][0] == ipa[x] and s[0][1] == ipa[x+1]:
            d = dirf
            if ipa[x+2]=="ː":
                d = dirf+"../sounds_slow/"
            if ipa[x-1]=="ˈ":
                d = dirf+"../sounds_slow/"
            if ipa[x-1]=="ˌ":
                d = dirf+"../sounds_fast/"


            files+="file \'" + d + s[1] + "\'\n"
            found_sound=True
            x+=2
            break
        elif s[0] == ipa[x]:
            d = dirf
            if ipa[x] != "#" and ipa[x+1]=="ː":
                d = dirf+"../sounds_slow/"
            if ipa[x] != "#" and ipa[x-1]=="ˈ":
                d = dirf+"../sounds_slow/"
            if ipa[x] != "#" and ipa[x-1]=="ˌ":
                d = dirf+"../sounds_fast/"



            files+="file \'" + d + s[1] + "\'\n"
            found_sound = True
            x+=1
            break
    if not found_sound:
        x+=1

print(files)

open("/tmp/asd.txt", "w").write(files)

subprocess.run(["ffmpeg", "-v", "0", "-f", "concat", "-y", "-safe", "0", "-i", "/tmp/asd.txt", "-af", "atempo=2.0", out])

print(ipa)
