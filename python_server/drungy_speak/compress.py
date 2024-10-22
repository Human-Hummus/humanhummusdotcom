import os
import subprocess
import sys, os, time


print("arg 0.. n-1 input files, arg2: output folder.")

todo = []
x = 1
out = sys.argv[len(sys.argv)-1]
while x < len(sys.argv)-1:
    todo.append(sys.argv[x])
    x+=1
print(out)



for i in todo:
    fout = i.split("/")[len(i.split("/"))-1]
    t = time.ctime(os.path.getmtime(i))
    print(fout)
    subprocess.call(["ffmpeg", "-i", i, 
                     "-af", "acompressor=threshold=-20dB:ratio=9:attack=1:release=100[a];[a]volume=4.0",
                     "-y",
                     out+fout])
