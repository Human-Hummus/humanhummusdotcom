console.log(document.cookie)
var is_uwu = false;
if (get_cookie("uwu_mode") == 'true'){is_uwu=true}     
//document.cookie = "yummy_cookie=choco";
//document.cookie = "tasty_cookie=strawberry";
console.log(document.cookie);
if (is_uwu == true){
        console.log("uwu mode engaged")
}
else{
        console.log("uwu mode disengaged")
}

function enable_uwu(){
        set_cookie("uwu_mode", true)
}
function disable_uwu(){
        set_cookie("uwu_mode", false)
}
function get_cookie(cname) {
  let name = cname + "=";
  let decodedCookie = decodeURIComponent(document.cookie);
  let ca = decodedCookie.split(';');
  for(let i = 0; i <ca.length; i++) {
    let c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}
function set_cookie(cname, cvalue, exdays=100) { 
  const d = new Date();
  d.setTime(d.getTime() + (exdays*24*60*60*1000));
  let expires = "expires="+ d.toUTCString();
  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}
