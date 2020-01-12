const $ = require('../../assets/jquery/jquery-3.4.1.min.js');

$(document).ready(function(){
    $('#segundo_menu').hide();
    $('#button_anterior').hide();
});


function proximo_menu(){
    $(document).ready(function(){
        $("#primeiro_menu").fadeOut(function(){
            $('#button_proximo').fadeOut(function(){
                window.setTimeout(function(){
                    $("#segundo_menu").fadeIn(function(){
                        $('#button_anterior').fadeIn();
                    });
                }, 500);
            });

        });
    });
}

function menu_anterior(){
    $(document).ready(function(){
        $("#segundo_menu").fadeOut(function(){
            $('#button_anterior').fadeOut(function(){
                window.setTimeout(function(){
                    $("#primeiro_menu").fadeIn(function(){
                        $('#button_proximo').fadeIn();
                    });
                }, 500);
            });
        });
    });
}