$(document).ready(function() {
  $('#tape_reference').focus(function() {
    var options = $('#tape_reference option');

    var values = $.map(options ,function(option) {
      return option.value;
    });

    $.each( values, function( optionId, optionVal ) {
      if($('#reference').val() == (optionVal)){
        window.exists = 1;
        alert('Tape already added');
        $('#reference').val("");
        $( '#reference' ).focus();
      }
    });

    if(window.exists != 1){
      addReference();
    }
    window.exists = 0;
  });


  $('#remove_tape').click(function (event){
     $("#tape_reference option:selected").remove();
     event.preventDefault();
  });
});

function addReference(){
  if ($( '#reference' ).val() != ""){

    var tape = $( '#reference' ).val();
    var tapes = $( '#tape_reference' )[0];
    var option = document.createElement("option");

    validateTape(tape);

    option.text = tape;
    tapes.add(option);

    $('#tape_reference').attr('size', $('#reference option').size());

    $( '#reference' ).val("");
    $( '#reference' ).focus();
  }
}

function validateTapeForm(){
  $('#tape_reference').each(function(){
    $('#tape_reference option').attr("selected","selected");
  });
}
