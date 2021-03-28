
$(document).ready(function(){

 window.addEventListener( 'message', function( event ) {
        var item = event.data;

        if ( item.showPlayerMenu == true ) {
	$('body').css('background-color','transparent');
	$('.motor').html(event.data.motor2);
	$('.gearing').html(event.data.gearing2);
	$('.bremser').html(event.data.bremser2);
	$('.turbo').html(event.data.turbo2);

$('.container-fluid').css('display','block');
} else if ( item.showPlayerMenu == false ) { // Hide the menu

$('.container-fluid').css('display','none');
$('body').css('background-color','transparent important!');
	$("body").css("background-image","none");

        }
    } );

    $("#motorstd").click(function(){
        $.post('http://kaz_tuning/motorstd', JSON.stringify({}));2
		    });
    $("#motoroko").click(function(){
        $.post('http://kaz_tuning/motoroko', JSON.stringify({}));2
		    });
    $("#motorstreet").click(function(){
        $.post('http://kaz_tuning/motorstreet', JSON.stringify({}));2
		    });
    $("#motorracer").click(function(){
        $.post('http://kaz_tuning/motorracer', JSON.stringify({}));2
		    });
    $("#bremsstd").click(function(){
        $.post('http://kaz_tuning/bremsstd', JSON.stringify({}));2
		    });
    $("#bremsoko").click(function(){
        $.post('http://kaz_tuning/bremsoko', JSON.stringify({}));2
		    });
    $("#bremsstreet").click(function(){
        $.post('http://kaz_tuning/bremsstreet', JSON.stringify({}));2
		    });
    $("#bremsracer").click(function(){
        $.post('http://kaz_tuning/bremsracer', JSON.stringify({}));2
		    });
    $("#gearstd").click(function(){
        $.post('http://kaz_tuning/gearstd', JSON.stringify({}));2
		    });
    $("#gearoko").click(function(){
        $.post('http://kaz_tuning/gearoko', JSON.stringify({}));2
		    });
    $("#gearstreet").click(function(){
        $.post('http://kaz_tuning/gearstreet', JSON.stringify({}));2
		    });
    $("#gearracer").click(function(){
        $.post('http://kaz_tuning/gearracer', JSON.stringify({}));2
		    });
    $("#turstd").click(function(){
        $.post('http://kaz_tuning/turoko', JSON.stringify({}));2
		    });
    $("#turoko").click(function(){
        $.post('http://kaz_tuning/turstd', JSON.stringify({}));2
    });

    $("#desempregado").click(function(){
        $.post('http://kaz_tuning/desempregado', JSON.stringify({}));2

    });
	
	$("#pescador").click(function(){
        $.post('http://kaz_tuning/pescador', JSON.stringify({}));2

    });
	
	$("#taxi").click(function(){
        $.post('http://kaz_tuning/taxi', JSON.stringify({}));2

    });
	
	$("#mecanico").click(function(){
        $.post('http://kaz_tuning/mecanico', JSON.stringify({}));2

    });
	
	$("#transportador").click(function(){
        $.post('http://kaz_tuning/transportador', JSON.stringify({}));2

    });
	
	$("#onibus").click(function(){
        $.post('http://kaz_tuning/onibus', JSON.stringify({}));2

    });

    $("#mineradima").click(function(){
        $.post('http://kaz_tuning/mineradima', JSON.stringify({}));2

    });
	
	$("#mineraouro").click(function(){
        $.post('http://kaz_tuning/mineraouro', JSON.stringify({}));2

    });
	
	$("#mineracobre").click(function(){
        $.post('http://kaz_tuning/mineracobre', JSON.stringify({}));2

    });
	
	$("#motoboy").click(function(){
        $.post('http://kaz_tuning/motoboy', JSON.stringify({}));2

    });

    $("#eletricista").click(function(){
        $.post('http://kaz_tuning/eletricista', JSON.stringify({}));2

    });
    

    // $("#cacador").click(function(){
    //    $.post('http://kaz_tuning/cacador', JSON.stringify({}));2
    // });

    //$("#caminhoneiro").click(function(){
    //    $.post('http://kaz_tuning/caminhoneiro', JSON.stringify({}));2

    //});
    
    $("#closebtn").click(function(){
        $.post('http://kaz_tuning/closeButton', JSON.stringify({}));2

    });

})
