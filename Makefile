build:
	nim compile --out=main main.nim
	fdm -i index.tdm -o index.html
