build:
	nim compile --out=main main.nim
	fdm -i index.fdm -o index.html
	fdm -i roadmap.fdm -o roadmap.html
	fdm -i interactives/index.tdm -o interactives/index.html
