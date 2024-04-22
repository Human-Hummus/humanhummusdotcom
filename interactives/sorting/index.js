const canvas = document.getElementById("data");
const ctx = canvas.getContext("2d");
ctx.imageSmoothingEnabled = false;

let datapoints_slider = document.getElementById("datapoints");
let speed_slider = document.getElementById("speed");
let algo_dropdown = document.getElementById("algo");
let set_button = document.getElementById("reset");
let run_button = document.getElementById("run");
let sn = document.getElementById("speed_num");
let dpn = document.getElementById("dpn");

const max_freq = 3000;

var audioCtx = new(window.AudioContext || window.webkitAudioContext)();

var oscillator = audioCtx.createOscillator();
function playNote(frequency, duration) {
  oscillator.type = 'square';
  oscillator.frequency.value = Math.round(frequency); // value in hertz
  oscillator.connect(audioCtx.destination);

  setTimeout(
    function() {
    }, duration);
}

set_button.addEventListener("click", reset);
run_button.addEventListener("click", run);
function speed(){
	return 1000/speed_slider.value
}

function start_osc(){
	stop_osc();
	oscillator.start()
}
function stop_osc(){
	audioCtx.close()
	audioCtx = new(window.AudioContext || window.webkitAudioContext)();
	oscillator = audioCtx.createOscillator();

}


let data = []
let prev_data_amt = datapoints_slider.value

let terminate = false
reset()

function redraw_screen(){
	let x = 0;
	let dp = datapoints_slider.value;
	sn.innerHTML = speed_slider.value
	dpn.innerHTML = datapoints_slider.value;
	ctx.fillStyle = "rgb(0 0 0)";
	ctx.fillRect(0, 1, dp, dp);
	while (x < data.length){
	       	ctx.fillStyle = "rgb(0 255 0)";
		let posx = x;
		let posy = dp-data[x];
		ctx.fillRect(posx,posy,1,1);
		x+=1;
	}
	if (datapoints_slider.value != prev_data_amt){
		reset()
	}
	prev_data_amt = datapoints_slider.value

}
const is_sorted = arr => arr.every((v,i,a) => !i || a[i-1] <= v);

async function reset(){
	stop_osc()
	console.log("reset");
	canvas.height = datapoints_slider.value*1.3;
	canvas.width = datapoints_slider.value*1.3;

	data = []
	let x = 0;
	while (x < datapoints_slider.value){
		data.push(x);
		x+=1;
	}
	await killall()
	data = shuffle(data)
}


//copied from stack overflow
function shuffle(array) {
  let currentIndex = array.length,  randomIndex;

  // While there remain elements to shuffle.
  while (currentIndex > 0) {

    // Pick a remaining element.
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;

    // And swap it with the current element.
    [array[currentIndex], array[randomIndex]] = [
      array[randomIndex], array[currentIndex]];
  }

  return array;
}

async function swap_data(pos1,pos2){
	playNote(pos1/datapoints_slider.value * max_freq+200, speed_slider.value/1000)
	playNote(pos2/datapoints_slider.value * max_freq+200, speed_slider.value/1000)
	let tmp = data[pos1];
	data[pos1] = data[pos2];
	data[pos2] = tmp;
	if (speed() > 2){
		await sleep(speed());
	}
}
async function set_data_pos(pos, val){
	playNote(val/datapoints_slider.value * max_freq+200, speed_slider.value/1000)
	data[pos] = val
	if (speed() > 2){
		await sleep(speed());
	}
}

async function bubblesort(){
	let bubblesort_cycles = 0;
	let bubblesort_pos = 0;
	while (bubblesort_cycles<data.length-1){
		if (terminate || is_sorted(data)){return}
		let end = data.length-bubblesort_cycles;
		if (data[bubblesort_pos] > data[bubblesort_pos+1]){
			await swap_data(bubblesort_pos, bubblesort_pos+1);
		}
		bubblesort_pos+=1;

		if (!(bubblesort_pos < end-1)){
			bubblesort_pos=0;
			bubblesort_cycles+=1;}
	}

}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function killall(){
	terminate = true;
	await sleep(0.5);
	terminate = false;
}

async function ctail(){
	let ctail_cycles = 0;
	let ctail_pos = 0;
	let ctail_dir = 1;
	while (ctail_cycles<data.length-1){
		if (terminate || is_sorted(data)){return}
		let end = 0;
		if (ctail_dir == 1){end = data.length-ctail_cycles/2;}
		else{end = Math.floor(ctail_cycles/2)}
	
		if (data[ctail_pos] > data[ctail_pos+1]){
			await swap_data(ctail_pos, ctail_pos+1);
		}
		ctail_pos+=ctail_dir;
		if (ctail_pos==end){
			ctail_dir*=-1;
			ctail_cycles+=1;
		}	}
}

async function gnomesort(){
	var pos = 0
	while (pos < data.length){
		if (pos == 0 || data[pos] >= data[pos-1]){pos+=1}
		else{await swap_data(pos,pos-1);pos-=1}
	}
}



async function insertion_sort(){
	var i = 1;
	while(i<data.length){
		var j = i;
		while (j>0 && data[j-1]>data[j]){
			await swap_data(j,j-1)
			j-=1
		}
		i+=1
	}
}

async function comb_sort(){
	let gap = data.length
	let shrink = 1.3
	let sorted = false
	while (!sorted){
		gap = Math.floor(gap/shrink)
		if (gap<=1){
			gap=1
			sorted=true
		}
		else if (gap == 9 || gap == 10){
			gap = 11
		}
		let i = 0
		while (i+gap < data.length){
			if (data[i] > data[i+gap]){
				await swap_data(i, i+gap)
				sorted=false
			}
			i+=1
		}
	}}
function range(start,end){
	var array = []
	var x = start
	while (x<end){
		array.push(x)
		x+=1
	}
	return array
}

async function cycle_sort(){
	for (var cycle_start = 0; cycle_start < data.length - 1; cycle_start+=1){
		var item = data[cycle_start];

		var pos = cycle_start;
		for (var i = cycle_start + 1; i < data.length; i+=1){
			if (data[i] < item){
				pos += 1;
			}
		}
		if (pos == cycle_start){
			continue;
		}
		while (item == data[pos]){
			pos += 1;
		}
		let temp = data[pos]
		await set_data_pos(pos, item);
		item = temp

		while (pos != cycle_start){
			pos = cycle_start;
			for (var i = cycle_start + 1; i < data.length; i+=1){
				if (data[i] < item){
					pos += 1;
				}
			}
			while (item == data[pos]){
				pos += 1;
			}
			let temp = data[pos]
			await set_data_pos(pos, item);
			item = temp
		}
	}
}


async function run(){
	console.log(range(0,10))
	start_osc()
	if (algo_dropdown.value == "bubble"){
		await bubblesort()
	}
	if (algo_dropdown.value == "cock"){
		await ctail()
	}
	if (algo_dropdown.value == "gnome"){
		await gnomesort()
	}
	if (algo_dropdown.value == "insertion"){
		await insertion_sort()
	}
	if (algo_dropdown.value == "comb"){
		await comb_sort()
	}
	if (algo_dropdown.value == "cycle"){
		await cycle_sort()
	}
	stop_osc()
}

setInterval(redraw_screen, 50);
