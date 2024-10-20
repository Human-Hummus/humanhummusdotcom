import tensorflow as tf
import random, sys
import numpy as np

datapoints = 10000
runn = 20
width = 1000
length = 5 
tl = 100

arg = 1
torun = ""
infile = ""
readfrom = ""
save_to = ""
model = None
while arg<len(sys.argv):
    if sys.argv[arg] == "run":
        torun = sys.argv[arg+1]
    elif sys.argv[arg] == "write":
        save_to = sys.argv[arg+1]
    elif sys.argv[arg] == "read":
        model = tf.keras.models.load_model(sys.argv[arg+1])
    elif sys.argv[arg] == "train":
        infile = sys.argv[arg+1]
    arg+=1


if model == None:
    m = []
    m.append(tf.keras.layers.Dense(100))
    for i in range(0,length):
        m.append(tf.keras.layers.Dense(width,activation='relu'))
    m.append(tf.keras.layers.Dense(127, activation="softmax"))
    model = tf.keras.Sequential(m)


test_inputs = []
test_outputs = []
data = ""
if infile != "":
    with open(infile, "r") as file:
        data = file.read()
    for _ in range(0, datapoints):
        d = []
        selected_num = random.randrange(100, len(data)-2)
        skip = random.randrange(0,75)
        for i in range(0, skip):d.append(0.0)
        for i in range(selected_num-(100-skip), selected_num):
            pot = ord(data[i])/127.0
            if pot >=1:pot=0.0
            d.append(pot)
        test_inputs.append(d)
        pot = ord(data[selected_num])
        pout = []
        for i in range(0,127):
            if i == pot:pout.append(1.0)
            else:pout.append(0.0)
        test_outputs.append(pout)



model.compile(optimizer='SGD',
        loss=tf.keras.losses.CategoricalCrossentropy(),
        metrics=[tf.metrics.CategoricalAccuracy()])

if infile != "":model.fit(np.array(test_inputs), np.array(test_outputs), epochs=runn)

stuff = []
for i in range(0,127):stuff.append(chr(i))

def make_chr(text):
    inp = []
    if len(text)-100 < 0:
        for i in range(len(text)-100, 0):
            inp.append(0)
    for i in range(len(text)-(100-len(inp)), len(text)):
        inp.append(ord(text[i])/127)
    predict = model.predict(np.array([inp]))[0]
    best,b1 = 0,-1
    for i in range(25,len(predict)):
        if predict[i] > b1:
            best,b1 = i, predict[i]
    print(chr(best))
    return random.choices(stuff, weights=tuple(predict), k=10)[0]
def make_text(text):
    output = text
    for i in range(0,tl):
        try:output+=make_chr(output)
        except Exception as e:print(e)
    print(output)


if torun !="":make_text(torun)

if save_to != "":model.save(save_to)
