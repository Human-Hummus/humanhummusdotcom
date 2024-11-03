
import csv

towrite = "extends Node\nvar past_admisstions = []\nvar admissions = ["

with open("Admissions.csv", mode ="r") as file:    
       csvFile = csv.DictReader(file)
       for lines in csvFile:
            towrite = towrite + "{\"text\":\"" + str(lines["Text"]) + "\"," + "\"gpa\":" + lines["High School GPA"] + ","+ "\"sat\":" + lines["SAT"] + ","+ "\"name\":\"" + lines["Name"] + "\","+ "\"age\":" + lines["Age"] + ","+ "\"awards\":\"" + lines["Awards"] + "\","+ "\"awards_value\":" + lines["Awards Value"] + ","+ "},"
towrite+="]"
open("main.gd", "w").write(towrite)

print(towrite)
