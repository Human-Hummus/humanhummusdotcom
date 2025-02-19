$(document).ready(function(){
	$(".main_header").hover(function(){
		$(".aka").toggleClass("hover");
	});
});
const observer = new IntersectionObserver((entries) => {
		entries.forEach((entry) => {
				console.log(entry);
				if (entry.isIntersecting) {
						entry.target.classList.add('show');
				}
				else {
						entry.target.classList.remove('show');
				}
		});
});

const hiddenElements = document.querySelectorAll(".hidden");
hiddenElements.forEach((el) => observer.observe(el));

const observer_left = new IntersectionObserver((entries) => {
		entries.forEach((entry) => {
				console.log(entry);
				if (entry.isIntersecting) {
						entry.target.classList.add('show_left');
				}
				else {
						entry.target.classList.remove('show_left');
				}
		});
});

const hiddenElements = document.querySelectorAll(".hidden_left");

