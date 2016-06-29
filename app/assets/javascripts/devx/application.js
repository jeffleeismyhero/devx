// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require ckeditor/init
//= require select2
//= require dropzone
//= require owl.carousel
//= require wow
//= require_tree ./ckeditor
//= require_tree .

$(function()
{

  // Activate WOW
  new WOW().init();

  // Notification
  if($(".cd-notification").is(":visible"))
  {
    $(".cd-notification").delay(3000).fadeOut("slow");
  }


  // Select2
  $(".select2").select2({ tags: true });
  $(".select2-multiple").select2({ tags: true, multiple: true });
  $(".select2-multiple-fixed").select2({ tags: false, multiple: true });
  $(".select2-fixed").select2({ tags: false, multiple: false });


  // JCW Accordion
  $(".accordion").jcw_accordion();


  // Navigation
  var active_path = window.location.pathname;

  $(".cd-side-nav a").each(function()
  {
    if($(this).attr("href") == active_path)
    {
      var active_link = null;

      if($(this).attr("data") != undefined)
      {
        active_link = $(this);
      }
      else
      {
        var parent = $(this).parent().parent().attr("data-parent");;

        $(".cd-side-nav a").each(function()
        {
          var o = $(this);

          if (o.attr("href") == active_path)
          {
            o.addClass("active")
          }

          if(o.attr("data") == parent)
          {
            active_link = $(this);
          }
        });
      }

      active_link.addClass("active");
    }
  });

  $(".cd-side-nav a.has-children").on("click", function()
  {
    var child = $(this).attr("data");

    $(".child-nav").each(function()
    {
      if($(this).hasClass("active"))
      {
        var same = $(this).attr("data-parent");
        $(this).removeClass("active");
      }

      if($(this).attr("data-parent") == child && $(this).attr("data-parent") != same)
      {
        $(this).addClass("active");
      }
    });

      return false;
  });


// Currency formatter
$(".currency-field").on("blur", function()
{
  $(this).val(parseFloat(Math.abs($(this).val())).toFixed(2));
})


  // Calendar type onchange event
  if($("#calendar_calendar_type").val() == "Google Calendar")
  {
      $("#google_calendar_fields").css("display", "block");
  }

  $("#calendar_calendar_type").on("change", function()
  {
      if($(this).val() == "Google Calendar")
      {
          $("#google_calendar_fields").css("display", "block");
      }
      else
      {
          $("#google_calendar_fields").css("display", "none");
      }
  });


  // DateTime Picker
  $(".datetimepicker").datetimepicker();

  $("#media-dropzone").dropzone({
    paramName: "medium[file]",
    queuecomplete: function()
    {
      location.reload();
    }
  });

  $("#document-dropzone").dropzone({
    paramName: "document[file]",
    queuecomplete: function()
    {
      location.reload();
    }
  });

  $("form:has(#cc_fields)").submit(function() {
    var form = this;
    // $(".submit").attr("disabled", true);
    // $("#credit-card input, #credit-card select").attr("name", "");
    // $("#credit-card-errors").hide();

    // if (!$("#credit-card").is(":visible")) {
    //   $("#credit-card input, #credit-card select").attr("disabled", true);
    //   return true;
    // }

    var card = {
      number:       $("#cc_number").val(),
      expMonth:     $("#_expiry_date_2i").val(),
      expYear:      $("#_expiry_date_1i").val(),
      cvc:          $("#cvv").val(),
      address_zip:  $("#zip_code").val(),
      name:         $("#ch_name").val()
    };

    Stripe.createToken(card, function(status, response) {
      if (status === 200) {
        //$(".last-4-digits").val(response.card.last4);
        $(".stripe-token").val(response.id);
        form.submit();
      } else {
        //$("#stripe-error-message").text(response.error.message);
        //$("#credit-card-errors").show();
        $(".submit").attr("disabled", false);
      }
    });

    return false;
  });


/**
  *
  * Calendar View
  *
  **/

  $("#list").on("click", function() {
    
    /* $(".listview").toggleClass("hide").toggleClass("show").fadeIn(1000, function() { }); */

    if ($(".gridview").hasClass("show")) {
      $(".gridview").removeClass("show").addClass("hide");
      $(".listview").removeClass("hide").addClass("show");
    }

    else 
      $(".listview").removeClass("hide").addClass("show");
  });  


  $("#grid").on("click", function() {

    /* $(".gridview").toggleClass("show").toggleClass("hide").fadeIn(1000, function() { }); */

    if ($(".listview").hasClass("show")) {
      $(".listview").removeClass("show").addClass("hide");
      $(".gridview").removeClass("hide").addClass("show");
    }

    else 
      $(".gridview").removeClass("hide").addClass("show");

  });

});