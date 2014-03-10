$(document).ready(function() {
	$('#tapes').focus(function() {
		var options = $('#tapes option');

		var values = $.map(options ,function(option) {
			return option.value;
		});

		$.each( values, function( optionId, optionVal ) {
			if($('#tape').val() == (optionVal)){
				var exists = 1;
				alert('Tape already added');
				$('#tape').val("");
				$( '#tape' ).focus();
			}
		});

		if(window.exists != 1){
			addTape();
		}
	});
});

function addTape(){
	if ($( '#tape' ).val() != ""){
		var tape = $( '#tape' ).val();
		var tapes = $( '#tapes' )[0];
		var option = document.createElement("option");

		option.text = tape;
		tapes.add(option);

		$('#tapes').attr('size', $('#tapes option').size());

		$( '#tape' ).val("");
		$( '#tape' ).focus();
	}
}

function validateForm(){
	$('#tapes').each(function(){
		$('#tapes option').attr("selected","selected");
	});
}