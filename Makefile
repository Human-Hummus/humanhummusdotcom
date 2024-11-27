build:
	nim compile --out=main main.nim
	fdm -i index.tdm -o index.html
	fdm -i tech_stuff.tdm -o tech_stuff.html
