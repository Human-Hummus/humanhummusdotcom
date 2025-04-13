build:
	fdm -i index.fdm -o index.html
	fdm -i drungy/index.fdm -o drungy/drungy.html
	fdm -i interactives/index.fdm -o interactives/index.html
	fdm -i interactives/admit_one/index.fdm -o interactives/admit_one/index.html
	fdm -i interactives/ascii_art/index.fdm -o interactives/ascii_art/index.html
	fdm -i interactives/YandolSim/info.fdm -o interactives/YandolSim/info.html
	fdm -i "functional software/index.fdm" -o "functional software/index.html"
	fdm -i "functional software/fdm.fdm" -o "functional software/fdm.html"
	fdm -i "functional software/mds.fdm" -o "functional software/mds.html"
	fdm -i "functional software/fdm_demo.fdm" -o "functional software/fdm_demo.html"
	fdm -i blog/drungy_story.fdm -o blog/drungy_story.html
	fdm -i blog/index.fdm -o blog/index.html
	fdm -i blog/networking-assignment.fdm -o blog/networking_assignment.html
	fdm -i blog/it_trends.fdm -o blog/it_trends.html
	fdm -i blog/ethics.fdm -o blog/ethics.html
	fdm -i python_server/drungy_speak.fdm -o python_server/drungy_speak.html
	fdm -i readme.fdm -f md -o README.md
