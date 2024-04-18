const canvas = document.getElementById("data");
const ctx = canvas.getContext("2d");
ctx.imageSmoothingEnabled = false;

let datapoints_slider = document.getElementById("datapoints");
let speed_slider = document.getElementById("speed");
let algo_dropdown = document.getElementById("algo");
let set_button = document.getElementById("reset");
let run_button = document.getElementById("run");
let sn = document.getElementById("speed_num");


const max_freq = 1000;

var audioCtx = new(window.AudioContext || window.webkitAudioContext)();

function playNote(frequency, duration) {
  // create Oscillator node
  var oscillator = audioCtx.createOscillator();

  oscillator.type = 'triangle';
  oscillator.frequency.value = frequency; // value in hertz
  oscillator.connect(audioCtx.destination);
  oscillator.start();

  setTimeout(
    function() {
      oscillator.stop();
      playMelody();
    }, duration);
}

set_button.addEventListener("click", reset);
run_button.addEventListener("click", run);


let data = []
let prev_data_amt = datapoints_slider.value

let terminate = false
reset()

function redraw_screen(){
	let x = 0;
	let dp = datapoints_slider.value;
	sn.innerHTML = speed_slider.value
	ctx.fillStyle = "rgb(0 0 0)";
	ctx.fillRect(0, 0, dp, dp);
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

function swap_data(pos1,pos2){
	playNote(pos1/datapoints_slider.value * max_freq, speed_slider.value/1000)
	playNote(pos2/datapoints_slider.value * max_freq, speed_slider.value/1000)
	let tmp = data[pos1];
	data[pos1] = data[pos2];
	data[pos2] = tmp;
}

async function bubblesort(){
	let bubblesort_cycles = 0;
	let bubblesort_pos = 0;
	while (bubblesort_cycles<data.length-1){
		if (terminate || is_sorted(data)){return}
		let end = data.length-bubblesort_cycles;
		if (data[bubblesort_pos] > data[bubblesort_pos+1]){
			swap_data(bubblesort_pos, bubblesort_pos+1);
		}
		bubblesort_pos+=1;

		if (!(bubblesort_pos < end-1)){
			bubblesort_pos=0;
			bubblesort_cycles+=1;}

		if (speed_slider.value > 1){
			await sleep(speed_slider.value);
		}
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
			swap_data(ctail_pos, ctail_pos+1);
		}
		ctail_pos+=ctail_dir;
		if (ctail_pos==end){
			ctail_dir*=-1;
			ctail_cycles+=1;
		}

		if (speed_slider.value > 1){
			await sleep(speed_slider.value);
		}
	}
}

async function gnomesort(){
	var pos = 0
	while (pos < data.length){
		if (pos == 0 || data[pos] >= data[pos-1]){pos+=1}
		else{swap_data(pos,pos-1);pos-=1}
		if (speed_slider.value > 1){
			await sleep(speed_slider.value);
		}
	}
}



async function insertion_sort(){
	var i = 1;
	while(i<data.length){
		var j = i;
		while (j>0 && data[j-1]>data[j]){
			swap_data(j,j-1)
			j-=1
			if (speed_slider.value > 1){
				await sleep(speed_slider.value);
			}
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
				swap_data(i, i+gap)
				if (speed_slider.value > 1){
					await sleep(speed_slider.value);
				}
				sorted=false
			}
			i+=1
		}
	}
}


function run(){
	if (algo_dropdown.value == "bubble"){
		bubblesort()
	}
	if (algo_dropdown.value == "cock"){
		ctail()
	}
	if (algo_dropdown.value == "gnome"){
		gnomesort()
	}
	if (algo_dropdown.value == "insertion"){
		insertion_sort()
	}
	if (algo_dropdown.value == "comb"){comb_sort()}
}

setInterval(redraw_screen, 100);
