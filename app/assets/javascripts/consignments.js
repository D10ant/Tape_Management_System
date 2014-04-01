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

function transitStatus(){
	var location1 = $( '#consignment_from_location_id option:selected').text();
	var location2 = $( '#consignment_to_location_id option:selected').text();

	location1 = location1.split(" - ");
	location2 = location2.split(" - ");

	if (location1[0] != location2[0]){
		 $( '#consignment_in_transit' ).val('true');
	} else {
		 $( '#consignment_in_transit' ).val('false');
	}
}

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

function getSecurityTag(){
	var securityTag = prompt("Please enter the security tag","");
}

function validateForm(){
	$('#tapes').each(function(){
		$('#tapes option').attr("selected","selected");
	});
}