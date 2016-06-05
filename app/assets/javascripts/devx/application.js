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
//= require_tree ./ckeditor
//= require_tree .

$(function()
{

  // Select2
  $(".select2").select2({ multiple: true });
  $(".select2-fixed").select2({ multiple: false });

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
          if($(this).attr("data") == parent)
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

});