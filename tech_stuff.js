var btn = document.getElementById("compile")


btn.onclick = async() => {
	var ptr = document.getElementById("ptr").value // ptr means Path To Root
	var title = document.getElementById("title").value
	if (ptr[ptr.length-1] != '/'){
		ptr+="/"
	}
	var html = `<!doctype html>
<html>
	<head>
		<title>Human Hummus</title>
		<meta charset="UTF-8">
		<link rel="icon" type="image/x-icon" href="`+ptr+`favicon.jpg" />
	</head>
	<body>
		<script>
			var path_to_root = "`+ptr+`";
		</script>
		<link rel="stylesheet" href="`+ptr+`style.css" />
		<center><h1>`+title+`</h1></center>
		<div class="main">
			<div class="menu" id="menu"></div>
			<div class="content">
				[CONTENT HERE]
			</div>
		</div>
		<script src="`+ptr+`main.js"></script>
		<script src="`+ptr+`changelog.js"></script>
		<script src="index.js"></script>
	</body>
</html>
	`
	var real_html = ""
	var torep = [
		["<","&lt;"],
		[">","&gt;"],
		["&","&amp;"],
	]
	var x = 0;
	while (x<html.length){
		var y = 0;
		var found = false
		while (y<torep.length){
			if (torep[y][0] == html[x]){
				x+=1;
				found=true
				real_html+=torep[y][1]
				break
			}
			y+=1
		}
		if (found){continue}
		real_html+=html[x]
		x+=1
	}
	document.getElementById("output").innerHTML = real_html
}
