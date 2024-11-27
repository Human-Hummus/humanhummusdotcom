tdm = ../the_document_maker/built/executable

build:
	nim compile --out=main main.nim
	$(tdm) -i index.tdm -o index.html
	$(tdm) -i tech_stuff.tdm -o tech_stuff.html
