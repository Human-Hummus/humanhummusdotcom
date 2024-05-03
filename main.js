var path_to_root
if (path_to_root == undefined){
	path_to_root="./"
} 

var menu = `
<ul class=cool-list> 
	<li><a href="`+path_to_root+`interactives/index.html">Interactive Experiences</a></li>
	<li><a href="`+path_to_root+`drungy/drungy.html">Educational Resource Regaurding Drungalwort</a></li>
	<li><a href="`+path_to_root+`functional software/index.html">Functional Software</a></li>
	<li><a href="`+path_to_root+`tech_stuff.html">Misc. Tech Stuff</a></li>
	<li><a href="`+path_to_root+`todo.html">TODO List</a></li>
	<li><a href="`+path_to_root+`config.html">Configure this site(WILL BE REPLACED SOON)</a></li>
</ul>
<center> -- CHANGE LOG -- </center>
<ul id="change_log" style="color:var(--standard-text-color);font-size:50%;">
</ul>
`;

console.log(document.cookie);
var is_uwu = false;
var power = "standard";
if (get_cookie("uwu_mode") == "true") {
	is_uwu = true;
}
if (get_cookie("power") == "high") {
	power = "high";
} else if (get_cookie("power") == "low") {
	power = "low";
} else {
	power = "standard";
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
function set_low_power() {
	power = "low";
	set_cookie("power", "low");
}
function set_standard_power() {
	power = "standard";
	set_cookie("power", "standard");
}
function set_high_power() {
	power = "high";
	set_cookie("power", "high");
}

function get_cookie(cname) {
	let name = cname + "=";
	let decodedCookie = decodeURIComponent(document.cookie);
	let ca = decodedCookie.split(";");
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

if (power != "low") {

	try {
		document.getElementById("cool_header").style = `
			animation-timing-function: linear;
			font-family: handdrawn;
			font-size: 600%;
			animation-iteration-count: infinite;
			animation-name: for_cool_header;
			animation-duration: 3s;
`;
	} catch {}
}
try {
	document.getElementById("menu").innerHTML = menu;
} catch {}
