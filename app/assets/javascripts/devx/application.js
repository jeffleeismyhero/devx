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
//= require jquery_ujs
//= require ckeditor/init
//= require select2
//= require dropzone
//= require_tree ./ckeditor
//= require_tree .

$(function()
{

  // Notification
  if($(".cd-notification").is(":visible"))
  {
    $(".cd-notification").delay(3000).fadeOut("slow");
  }


  // Select2
  $(".select2").select2({ tags: true });
  $(".select2-multiple").select2({ tags: true, multiple: true });
  $(".select2-fixed").select2({ tags: false, multiple: false });



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

});

// $(function()
// {
//   Dropzone.autoDiscover = false;
//   Dropzone.paramName = "medium[file]";

//   var mediaDropzone = new Dropzone("#media-dropzone");
//   return mediaDropzone.on("success", function(file, responseText)
//   {
//     var imageUrl = responseText.file_name.url;
//   });
// });