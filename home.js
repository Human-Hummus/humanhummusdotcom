var body = document.getElementById("thebody");
var siteslist = document.getElementById("the_sites_list");
var config_button = document.getElementById("openconfig");
var config_menu = document.getElementById("configmenu");
var close_config_button = document.getElementById("closeconfig");
var save_and_apply = document.getElementById("save_and_apply");
var bg_color_picker = document.getElementById("bg_color_picker");
var text_color_picker = document.getElementById("text_color_picker");
var config_sites_list = document.getElementById("sites_list_config");
var new_site_name = document.getElementById("config_site_name");
var new_site_url = document.getElementById("config_site_url");

document.getElementById("config_add_site_button").onclick = async () => {
	var site_div = document.createElement("div");

	var site_title = document.createElement("input");
	site_title.type = "text";
	site_title.id = "sitetitle";
	site_title.value = new_site_name.value;

	site_div.appendChild(site_title);

	var site_url = document.createElement("input");
	site_url.type = "text";
	site_url.id = "siteurl";
	site_url.value = new_site_url.value;

	site_div.appendChild(site_url);

	config_sites_list.appendChild(site_div);
};

const site_sep = "ʮ";
var is_config = false;

config_button.onclick = async () => {
	is_config = true;
};
close_config_button.onclick = async () => {
	is_config = false;
};
save_and_apply.onclick = async () => {
	home.bg_color = bg_color_picker.value;
	home.text_color = text_color_picker.value;

	var todo = config_sites_list.children;
	var x = 0;
	home.sites = [];
	while (x < todo.length) {
		console.log(todo[x]);
		var site_to_add = ["", ""];
		var y = 0;
		var todochild = todo[x].children;
		while (y < todochild.length) {
			if (todochild[y].id == "siteurl") {
				site_to_add[0] = todochild[y].value;
			}
			if (todochild[y].id == "sitetitle") {
				site_to_add[1] = todochild[y].value;
			}
			y += 1;
		}
		home.sites.push(site_to_add);

		x += 1;
	}

	save_config();
	setup();
};

var home = {
	bg_color: "#2b2730",
	text_color: "#FFFFFF",
	sites: [],
};

function setup() {
	body.style.backgroundColor = home.bg_color;
	var x = 0;
	var sites_list = "";
	config_sites_list.innerHTML = "";
	while (x < home.sites.length) {
		if (home.sites[x][1] == "" || home.sites[x][0] == "") {
			x += 1;
			continue;
		}
		var site_div = document.createElement("div");
		site_div.style.display = "flex";
		site_div.style.flexDirection = "row";
		if (!home.sites[x][0].includes("https") && !home.sites[x][0].includes("http")) {
			home.sites[x][0] = "https://" + home.sites[x][0];
		}
		if (home.sites[x].length > 0 && home.sites[x][0] != "") {
			sites_list += '<li><a href="' + home.sites[x][0] + '" style="font-size:200%;color:' + home.text_color + ';">' + home.sites[x][1] + "</a></li>";
		}

		var site_title = document.createElement("input");
		site_title.type = "text";
		site_title.id = "sitetitle";
		site_title.value = home.sites[x][1];

		site_div.appendChild(site_title);

		var site_url = document.createElement("input");
		site_url.type = "text";
		site_url.id = "siteurl";
		site_url.value = home.sites[x][0];

		site_div.appendChild(site_url);

		config_sites_list.appendChild(site_div);
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
		x += 1;
		var text_color = "";
		while (x < c.length && c[x] != "-") {
			console.log(c[x]);
			text_color += c[x];
			x += 1;
		}
		home.text_color = text_color;
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
bg_color_picker.value = home.bg_color;
text_color_picker.value = home.text_color;

function save_config() {
	var to_save = "";
	to_save += home.bg_color;
	to_save += "-";
	to_save += home.text_color;
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

config_loop();

setInterval(config_loop, 100);
