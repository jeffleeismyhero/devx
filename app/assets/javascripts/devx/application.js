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
//= require social-share-button
//= require fancybox
//= require velocity
//= require photoswipe
//= require wow
//= require typed
//= require_tree ./ckeditor
//= require_tree .
//= require_self

$(function()
{

  // Activate WOW
  new WOW().init();


  // Stripe
  $("form#new_order").on("submit", function()
  {
    var form = this;

    var card = {
      number:       $("#cc_number").val(),
      expMonth:     $("#_expiry_date_2i").val(),
      expYear:      $("#_expiry_date_1i").val(),
      cvc:          $("#cvv").val(),
      address_zip:  $("#zipcode").val(),
      name:         $("#ch_name").val()
    };

    if (typeof Stripe != "undefined"){
    Stripe.createToken(card, function(status, response)
    {
      if (status === 200)
      {
        console.log(response.id);
        $(".stripe-token").val(response.id);
        form.submit();
      }
      else
      {
        console.log(response);
      }
    });
    }

    return false;
  });


  // Notification
  if($(".cd-notification").is(":visible"))
  {
    $(".cd-notification").delay(3000).fadeOut("slow");
  }


  // Mobile Navigation
  $("#mobile-toggle-btn").on("click", function()
  {
    $("#cd-mobile-nav").toggleClass("active");
  });


  // Select2
  $(".select2").select2({ tags: true });
  $(".select2-multiple").select2({ tags: true, multiple: true });
  $(".select2-multiple-fixed").select2({ tags: false, multiple: true });
  $(".select2-fixed").select2({ tags: false, multiple: false });


  //Fancybox
  $("a.fancybox").fancybox({ type: 'iframe' });
  $("a.fancybox-gallery").fancybox();


  // JCW Accordion
  $(".accordion").jcw_accordion();


  // Owl Carousel
  $(".devx-owl").owlCarousel({
    items: 1,
    singleItem: true
  });

  // Owl Carousel
  $(".owlcarousel").owlCarousel({
    items: 1,
    autoPlay:true,
    paginationNumbers: true,
    singleItem:true,
    loop:true
  });


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


  // Form builder validations
  $("form#form-builder").on("submit", function()
  {
    var invalid_fields = [];

    $(this).find("input, select").each(function()
    {
      if ($(this).prop("required") && $(this).val() == "")
      {
        if ($(this).attr("id") != "_expiry_date_1i" && $(this).attr("id") != "_expiry_date_2i")
        {
          invalid_fields.push($(this).prev("label").text());
        }
        else
        {
            invalid_fields.push("Expiration Date");
        }
      }
    });

    if (invalid_fields.length > 0)
    {
      msg = "";

      $(invalid_fields).each(function(f)
      {
        msg += invalid_fields[f] + " is a required field\n\r"
      });

      alert(msg);
      return false;
    }
    else if (invalid_fields.length == 0)
    {
        $("form#form-builder").submit();
    }

    return false;
  });


  // Currency formatter
  $("form#form-builder").on("submit", function()
  {
    if ($(".currency-field").val() != "")
    {
      value = parseFloat($(this).val().replace(/[^0-9\.]+/g, '')).toFixed(2);
      if (value == "NaN")
      {
        value = 0
      }

      $(".currency-field").val(value);
    }
  });

  $(".currency-field").on("blur", function()
  {
    if ($(this).val() != "")
    {
      value = parseFloat($(this).val().replace(/[^0-9\.]+/g, '')).toFixed(2);
      if (value == "NaN")
      {
        value = 0
      }

      $(this).val(value);

      if ($("input[type=submit]").attr("value").startsWith("Give"))
      {
        $("input[type=submit]").attr("value", "Give $" + value);
      }
    }
  });



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
  $('.datepicker').datetimepicker({timepicker: false, format: 'm/d/Y'});
  $('.timepicker').timepicker({
    'timeFormat': 'g:i a',
    'step': 15,
    'selectOnBlur': false,
    'scrollDefaultNow': true,
    'forceRoundTime': false
  });

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

  $("#article-gallery-dropzone").dropzone({
    paramName: "article_gallery[file]",
    queuecomplete: function()
    {
      //location.reload();
    }
  });

  $("#class-gallery-dropzone").dropzone({
    paramName: "class_photo[filename]",
    queuecomplete: function()
    {
      //location.reload();
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

    if (typeof Stripe != "undefined") {
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
    }
    else {
      // form.submit();
    }

    return false;
  });


/**
  *
  * Calendar View
  *
  **/

  $("#list").on("click", function() {

    /* $(".listview").toggleClass("hide").toggleClass("show").fadeIn(1000, function() { }); */

    if ($(".gridview, .monthview, .weekview").hasClass("show")) {
      $(".gridview, .monthview, .weekview").removeClass("show").addClass("hide");
      $(".listview").removeClass("hide").addClass("show");
    }

    else
      $(".listview").removeClass("hide").addClass("show");

    return false;
  });


  $("#grid").on("click", function() {

    /* $(".gridview").toggleClass("show").toggleClass("hide").fadeIn(1000, function() { }); */

    if ($(".listview, .monthview, .weekview").hasClass("show")) {
      $(".listview, .monthview, .weekview").removeClass("show").addClass("hide");
      $(".gridview").removeClass("hide").addClass("show");
    }

    else
      $(".gridview").removeClass("hide").addClass("show");

    return false;

  });


  $("#month").on("click", function() {

    /* $(".gridview").toggleClass("show").toggleClass("hide").fadeIn(1000, function() { }); */

    if ($(".listview, .gridview, .weekview").hasClass("show")) {
      $(".listview, .gridview, .weekview").removeClass("show").addClass("hide");
      $(".monthview").removeClass("hide").addClass("show");
    }

    else
      $(".monthview").removeClass("hide").addClass("show");

    return false;

  });


  $("#week").on("click", function() {

    /* $(".gridview").toggleClass("show").toggleClass("hide").fadeIn(1000, function() { }); */

    if ($(".listview, .gridview, .monthview").hasClass("show")) {
      $(".listview, .gridview, .monthview").removeClass("show").addClass("hide");
      $(".weekview").removeClass("hide").addClass("show");
    }

    else
      $(".weekview").removeClass("hide").addClass("show");

    return false;

  });

  if ($(window).outerWidth() >= 1024)
  {
    $(".monthview").removeClass("hide").addClass("show");
  }
  else
  {
    $(".gridview").removeClass("hide").addClass("show");
  }

});
