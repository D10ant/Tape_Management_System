$(document).ready(function() {
	$('#tapes').focus(function() {
		var options = $('#tapes option');

		var values = $.map(options ,function(option) {
			return option.value;
		});

		$.each( values, function( optionId, optionVal ) {
			if($('#tape').val() == (optionVal)){
				window.exists = 1;
				alert('Tape already added');
				$('#tape').val("");
				$( '#tape' ).focus();
			}
		});

		if(window.exists != 1){
			addTape();
		}
		window.exists = 0;
	});


	$('#remove_tape').click(function (event){
		 $("#tapes option:selected").remove();
		 event.preventDefault();
	});

	$('#tape-add-no').click(function (event){
		var x = document.getElementById("tapes");
		if (x.length>0) {
  			x.remove(x.length-1);
  		}
	})

	$('#tape-add').click(function (event){
		var tape = $('#tapes option:last-child').val();
		var customer = $("#customer").val();
		console.log(customer);
		createTape(tape, customer);

	})
});

function addTape(){
	if ($( '#tape' ).val() != ""){

		var tape = $( '#tape' ).val();
		var tapes = $( '#tapes' )[0];
		var option = document.createElement("option");

		validateTape(tape);

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

//code modified from http://stackoverflow.com/questions/5815687/check-username-availability
function validateTape(tape){
	$.get('/consignments/checktape', {
		tape: tape
	}).success(function(data) {
		if(data == 'true'){

		} else {
			$( "#unknown-tape" ).trigger( "click" );
		}

	}).error(function() {
		$this.addClass('');
	});
}

function createTape(tape_ref, customer){
	console.log(tape_ref);
	console.log(customer);

	$.ajax({
		url: "/tapes",
		type: "POST",
		data: {
			tape: {
				reference: tape_ref,
				customer_id: customer
			}
		},
		beforeSend: function(jqXHR, settings) {
        jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    },
		success: function(data){
			alert('Tape ' + tape_ref + ' successfully added');
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
        alert("Status: " + textStatus); alert("Error: " + errorThrown);
    }
	});
}
