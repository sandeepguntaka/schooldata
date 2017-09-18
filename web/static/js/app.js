// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

(function($){
    $(function(){

      $(document).on("click", "a.delete-row", function () {
        $(this).parent().parent().remove();
        return false;
      });
      
    $('.button-collapse').sideNav();
    $('.carousel.carousel-slider').carousel({fullWidth: true});
    setInterval(function() {
        $('.carousel').carousel('next');
      }, 8000);    

    }); // end of document ready

    $('.payment_add_more').click(function() {
      var tr_count = $('.payment-types tbody tr').length;
      var new_tr = $('.payment-types tbody tr:first').clone();

      var payment_name = "payment_id["+(tr_count+1)+"]" 
      $('.payment-type', $(new_tr)).attr('name', payment_name);
      
      var amount_name = "amount["+(tr_count+1)+"]" 
      $('.amount', $(new_tr)).attr('name', amount_name);
      
      $('.delete-row', $(new_tr)).removeClass('hidden');
      $('.payment-types tbody tr:last').after(new_tr);
      return false;
    });
    

  })(jQuery); // end of jQuery name space