var body = document.getElementById("thebody");
var siteslist = document.getElementById("the_sites_list");
var config_button = document.getElementById("openconfig");
var config_menu = document.getElementById("configmenu");
var close_config_button = document.getElementById("closeconfig");
var save_and_apply = document.getElementById("save_and_apply");
var bg_color_picker = document.getElementById("bg_color_picker");

const site_sep = "ʮ";
var is_config = false;

config_button.onclick = async () => {
	is_config = true;
};
close_config_button.onclick = async () => {
	is_config = false;
};
save_and_apply.onclick = async () => {
	home.bg_color = bg_color_picker.value
	save_config()
	setup()
}

var home = {
	bg_color: "#2b2730",
	text_color: "#FFFFFF",
	sites: [],
};

function setup() {
	body.style.backgroundColor = home.bg_color;
	var x = 0;
	var sites_list = "";
	while (x < home.sites.length) {
		if (!home.sites[x].includes("https://") && !home.sites[x].includes("http://")){
			home.sites[x][0] = "https://" + home.sites[x][0]
		}
		if (home.sites[x].length > 0 && home.sites[x][0] != "") {
			sites_list += '<li><a href="' + home.sites[x][0] + '" style="font-size:200%;color:' + home.text_color + ';">' + home.sites[x][1] + "</a></li>";
		}
		x += 1;
	}
	console.log(sites_list);
	siteslist.innerHTML = sites_list;
}

function get_home_stuff() {
	var bg_color = "";
	var c = get_cookie("home");
	if (c != "") {
		var x = 0;
		while (x < c.length && c[x] != "-") {
			console.log(c[x]);
			bg_color += c[x];
			x += 1;
		}
		home.bg_color = bg_color;
		var cur_state = false; // false is reading site URL true is reading site title
		x += 1;
		var cur_site = [];
		var curs = "";
		while (x < c.length) {
			console.log("cur site: " + cur_site);
			console.log("curs: " + curs);
			console.log(c[x]);
			if (c[x] == site_sep) {
				cur_state = !cur_state;
				cur_site.push(curs);
				if (cur_state == false) {
					home.sites.push(cur_site);
					cur_site = [];
				}
				curs = "";
				x += 1;
				continue;
			}
			curs += c[x];
			x += 1;
		}
	}
}

get_home_stuff();
setup();
bg_color_picker.value=home.bg_color

function save_config() {
	var to_save = "";
	to_save += home.bg_color;
	to_save += "-";
	var x = 0;
	while (x < home.sites.length) {
		to_save += home.sites[x][0] + site_sep + home.sites[x][1] + site_sep;
		x += 1;
	}
	set_cookie("home", to_save);
}

var replacems = [
	["%", 25],
	["™", 99],
	["˜", 98],
	["—", 97],
	["-", 96],
	["&", 26],
	["•", 95],
	["‰", 89],
	["ˆ", 88],
	["‡", 87],
	["†", 86],
	["…", 85],
	["„", 84],
	["ƒ", 83],
	["‚", 82],
	["€", 80],
	["`", 60],
	["@", 40],
	[")", 29],
	["(", 28],
	["'", 27],
	["$", 24],
	["#", 23],
	['"', 22],
	["!", 21],
	["+", "2B"],
	["*", "2A"],
	[",", "2C"],
	["/", "2F"],
	[":", "3A"],
	[";", "3B"],
	["<", "3C"],
	["=", "3D"],
	[">", "3E"],
	["?", "3F"],
];
document.getElementById("search-field").addEventListener("keydown", (event) => {
	if (event.keyCode == 13) {
		var tourl = "";
		var val = document.getElementById("search-field").value;
		var x = 0;
		var real_val = "";
		while (x < val.length) {
			var y = 0;
			while (y < replacems.length) {
				if (val.charAt(x) == replacems[y][0]) {
					real_val += "%" + replacems[y][1].toString();
					console.log(real_val);
					x += 1;
					break;
				}
				y += 1;
			}
			real_val += val.charAt(x);
			x += 1;
		}
		val = real_val;
		switch (document.getElementById("search-engine").value) {
			case "duckduckgo":
				tourl = "https://duckduckgo.com/?q=" + val;
				break;
			case "google":
				tourl = "https://google.com/search?q=" + val;
				break;
			case "mojeek":
				tourl = "https://www.mojeek.com/search?q=" + val;
				break;
			case "yahoo":
				tourl = "https://search.yahoo.com/search?q=" + val;
				break;
			case "startpage":
				tourl = "https://www.startpage.com/search?q=" + val;
				break;
		}
		window.location.replace(tourl);
	}
});

function config_loop() {
	if (!is_config) {
		config_menu.style.display = "none";
		return;
	}
	config_menu.style.display = "flex";
}

setInterval(config_loop, 100);
