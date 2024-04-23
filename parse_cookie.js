console.log(document.cookie)
var is_uwu = false;
if (!(document.cookie == "" || document.cookie == undefined)){
	for (line in document.cookie.split(";")){
		if (line.includes("enable_uwu_mode")){
			is_uwu = true;
			if (line.includes("false")){is_uwu=false}
		}
	}
}
//document.cookie = "yummy_cookie=choco";
//document.cookie = "tasty_cookie=strawberry";
console.log(document.cookie);
if (is_uwu){
	console.log("uwu mode engaged")
}
else{
	console.log("uwu mode disengaged")
}

function enable_uwu(){
	if (!is_uwu){
		is_uwu = true
		document.cookie = "enable_uwu_mode=true; expires=Fri, 31 Dec 9999 23:59:59 GMT;SameSite=None; Secure"
	}
}
function disable_uwu(){
	if (is_uwu){
		is_uwu = false
		document.cookie = "enable_uwu_mode=false; expires=Fri, 31 Dec 9999 23:59:59 GMT;SameSite=None; Secure"
	}
}

