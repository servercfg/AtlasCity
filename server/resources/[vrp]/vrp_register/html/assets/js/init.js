$(document).ready(function(){
  $('select').formSelect();

  // LUA event listener
  window.addEventListener('message', function(event) {
    if (event.data.action == 'open') {
      $('#wrapper').show();
    } else if (event.data.action == 'close') {
      $('#wrapper').hide();
    }
  });

  // Register button
  $('#register').click(function() {
    if ($('#lastname').val() != '' && $('#firstname').val() != '' && $('#dateofbirth').val() != '' ) {
      if ($('#dateofbirth').val().length == 2) {
        var dob = $('#dateofbirth').val();

        $.post('http://vrp_register/opretborger', JSON.stringify({
          firstname: $("#firstname").val(),
          lastname: $("#lastname").val(),
          dateofbirth: $("#dateofbirth").val()
        }));
      } else {
        $.post('http://vrp_register/agelimit', JSON.stringify({}));
      }
    }
  });

  // Disable space on the input
  $("form").on({
	  keydown: function(e) {
	    if (e.which === 32)
	      return false;
	  },
	});

  // Disable form submit
  $("form").submit(function() {
		return false;
  });
  
  // Escape key event + reset the page
  $(document).keyup(function(e) {
    if ( e.keyCode == 27 ) {
      $('#wrapper').hide();
      $.post('http://vrp_register/escape', JSON.stringify({}));
    }
 });
});