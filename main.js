var path_to_root;
if (path_to_root == undefined) {
	path_to_root = "./";
}

console.log(document.cookie);
var is_uwu = false;

if (get_cookie("uwu_mode") == "true") {
	is_uwu = true;
}
console.log(document.cookie);
if (is_uwu == true) {
	console.log("uwu mode engaged");
} else {
	console.log("uwu mode disengaged");
}

function enable_uwu() {
	is_uwu = true;
	set_cookie("uwu_mode", true);
}
function disable_uwu() {
	is_uwu = false;
	set_cookie("uwu_mode", false);
}
function get_cookie(cname) {
	let name = cname + "=";
	let decodedCookie = decodeURIComponent(document.cookie);
	let ca = decodedCookie.split(";");
	console.log(ca);
	for (let i = 0; i < ca.length; i++) {
		let c = ca[i];
		while (c.charAt(0) == " ") {
			c = c.substring(1);
		}
		if (c.indexOf(name) == 0) {
			return c.substring(name.length, c.length);
		}
	}
	return "";
}
function set_cookie(cname, cvalue, exdays = 100) {
	const d = new Date();
	d.setTime(d.getTime() + exdays * 24 * 60 * 60 * 1000);
	let expires = "expires=" + d.toUTCString();
	document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

document.getElementById("boykb").onclick = async () => \{
	var uwup = document.getElementById("uwu_prompt");

	var ms = document.getElementById("meow_sound");
	if (!is_uwu) {
		enable_uwu();
		is_uwu = true;
		uwup.innerHTML = "UwU mode:   <b>ACTIVATED</b>";
		ms.src = "{var:path_to_root}assets/meow.ogg";
	} else {
		uwup.innerHTML = "UwU mode: <b>DEACTIVATED</b>";
		disable_uwu();
		is_uwu = false;
		ms.src = "{var:path_to_root}assets/im_really_mad.ogg";
	}
	ms.cloneNode().play();
	uwup.hidden = false;
	await new Promise((resolve) => setTimeout(resolve, 4000));
	uwup.hidden = true;
};
bkimg = document.getElementById("bkimg");
var bk_state = false;
function boykisser_updater() {
	if (is_uwu && !bk_state) {
		bk_state = true;
		bkimg.src = "{var:path_to_root}assets/boykisser_cool.webp";
	}
	if (!is_uwu && bk_state) {
		bk_state = false;
		bkimg.src = "{var:path_to_root}assets/boykisser.webp";
	}
}
setInterval(boykisser_updater, 100);
