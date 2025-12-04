const btn = document.getElementById("accountBtn");
const menu = document.getElementById("accountMenu");

// Click để mở đóng menu
btn.addEventListener("click", () => {
	menu.classList.toggle("show");
});

// Click ra ngoài thì đóng menu
document.addEventListener("click", (e) => {
	if (!btn.contains(e.target) && !menu.contains(e.target)) {
		menu.classList.remove("show");
	}
});