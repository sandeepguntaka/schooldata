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

import { Schooldata } from "web/static/js/schooldata";

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

    $("#per_page").change(function() {
     $('#booking_filters').closest("form").submit();
    });

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
    

    var student_ids = function(event_element, output_element) {
        var code = $(event_element).val();
        if(code != "") {
            var promise = Schooldata.student_ids(code)
		    var options = '<option value="">-- Select Student --</option>';
            promise.done(function( data ) {
		        $.each(data, function(name, val) {
			       options += '<option value="' + val + '">' + name + '</option>';
			    });
		        $(output_element).html("");
		        $(output_element).append(options);
		    });
        } else {
            $(output_element).html("");
            $(output_element).html("<option value=''>-- Select Student --</option>");
        }
    }
    
    $(".class_id").change(function() {
	    student_ids(".class_id", ".student_id");
	})





  $(document).ready(function () {
    var navListItems = $('div.setup-panel div a'),
            allWells = $('.setup-content'),
            allNextBtn = $('.nextBtn'),
          allPrevBtn = $('.prevBtn');
  
    allWells.hide();
  
    navListItems.click(function (e) {
        e.preventDefault();
        var $target = $($(this).attr('href')),
                $item = $(this);
  
        if (!$item.hasClass('disabled')) {
            navListItems.removeClass('btn-primary').addClass('btn-default');
            $item.addClass('btn-primary');
            allWells.hide();
            $target.show();
            $target.find('input:eq(0)').focus();
        }
    });
    
    allPrevBtn.click(function(){
        var curStep = $(this).closest(".setup-content"),
            curStepBtn = curStep.attr("id"),
            prevStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().prev().children("a");
  
            prevStepWizard.removeAttr('disabled').trigger('click');
    });
  
    allNextBtn.click(function(){
        var curStep = $(this).closest(".setup-content"),
            curStepBtn = curStep.attr("id"),
            nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
            curInputs = curStep.find("input[type='text'],input[type='url']"),
            isValid = true;
  
        $(".form-group").removeClass("has-error");
        for(var i=0; i<curInputs.length; i++){
            if (!curInputs[i].validity.valid){
                isValid = false;
                $(curInputs[i]).closest(".form-group").addClass("has-error");
            }
        }
  
        if (isValid)
            nextStepWizard.removeAttr('disabled').trigger('click');
    });
  
    $('div.setup-panel div a.btn-primary').trigger('click');
  });



  })(jQuery); // end of jQuery name space