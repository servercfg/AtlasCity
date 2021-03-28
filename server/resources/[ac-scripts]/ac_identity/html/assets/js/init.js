$(document).ready(function(){
  window.addEventListener('message', function( event ) {
		if (event.data.action == 'show') {
				console.log(event.data)
				console.log(event.data.array)
				console.log(event.data.array.user.age);
				var name				= event.data.array.user.firstname + " " +  event.data.array.user.name;
				var home        = event.data.array.user.home;
				var age 		    = event.data.array.user.age;
				var number		  = event.data.array.user.number;
				var pnumber			= event.data.array.user.pnumber
				var cpr 		  	= event.data.array.user.registration;
				var license   	= event.data.array.licenses.license;
				var job 				= event.data.array.user.job;
				if(home == undefined) {
					home = "Ukendt"
				}
				if(number == undefined) {
					number = "00"
				}

			if ( license == "Nej") {
				$('.name').text(name);
				$('.socialcpr').text(cpr);
				$('.pnumber').text(pnumber);
				$('#id-card').css('background', 'url(assets/images/idcard.png)');
				$('#id-card').show();
			} else {
				$('.lastname').text(event.data.array.user.name);
				$('.firstname').text(event.data.array.user.firstname);
				$('.licensedob').text(age + 'år');
				$('.validfrom').text('20.03.2018');
				$('.validto').text('20.03.2033');
				$('.police').text(job);
				$('.cpr').text(cpr);
				$('.licensenr').text(home + ", " + number + ", 2900, Danmark");
				$('.pnumber2').text(event.data.array.user.pnumber);
				$('.sig').text(name);
				$('#license').css('background', 'url(assets/images/license.png)');
				$('#license').show();
			}
		} else if (event.data.action == 'hide') {
			$('#id-card').hide();
			$('#license').hide();
		}
	})
});
