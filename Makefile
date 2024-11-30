build:
	nim compile --out=main main.nim
	fdm -i index.fdm -o index.html
	fdm -i roadmap.fdm -o roadmap.html
	fdm -i interactives/index.fdm -o interactives/index.html
	fdm -i "functional software/index.fdm" -o "functional software/index.html"
	fdm -i drungy/index.fdm -o drungy/drungy.html
	fdm -i interactives/admit_one/index.fdm -o interactives/admit_one/index.html
