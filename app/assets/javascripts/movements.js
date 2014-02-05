$(document).ready(function() {
	$('#tape').bind('keyup', function (e) {
		var key = e.keyCode || e.which;
		if (key === 13) {

			//e.preventDefault();
			//return false;

			var tape = document.getElementById('tape').value;
			var tapes = document.getElementById('tapes');
			var option = document.createElement("option");

			option.text = tape;
			tapes.add(option);

			document.getElementById('tape').value = "";
		//	e.preventDefault();
		} 
	});
});

$('#new_movement').submit(function() {
	return false;
});

function validateForm(){
	return false;
}