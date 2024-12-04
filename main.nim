import std/os, strutils
proc get_var*(var_name:string):string =
  var
    p = paramStr(2)
    x = 0
    content = ""
    name = ""
    on_name = true
  while x < p.len():
    if p[x] == '\\':
      x+=1
      content.add(p[x])
    elif p[x] == ':':
      on_name = false
    elif p[x] == '|':
      on_name=true
      if name == var_name:return content
      content = ""
      name = ""
    else:
      if on_name:name.add(p[x])
      else:content.add(p[x])
    x+=1
  return ""

var path_to_root = get_var("path_to_root")
if path_to_root == "":
  echo "PATH TO ROOT DOESN'T EXIST"
  quit(1)
if not (path_to_root[^1] == '/'): path_to_root.add "/"

echo "{import:"&path_to_root&"header.fdm}"
echo paramStr(1)
echo "{import:"&path_to_root&"footer.fdm}"
