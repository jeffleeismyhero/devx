$ ->
  $("form").on "click", ".add_fields", (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data("id"), "g")
    $(this).parent().children(".nested-attributes").append($(this).data("fields").replace(regexp, time))
    event.preventDefault()
    $(".select2").select2({ tags: true });
    $(".select2-multiple").select2({ tags: true, multiple: true });
    $(".select2-multiple-fixed").select2({ tags: false, multiple: true });
    $(".select2-fixed").select2({ tags: false, multiple: false });
    $('.datepicker').datetimepicker({timepicker: false, format: 'm/d/Y'});
    $('.timepicker').timepicker({
      'timeFormat': 'g:i a',
      selectOnBlur: true,
      scrollDefaultNow: true
    });

  $("form").on "click", ".remove_fields", (event) ->
    $(this).prev("input[type=hidden]").val("1")
    $(this).parent().parent().hide()
    event.preventDefault()

  $(".sortable-menu").sortable
    axis: "y"
    update: ->
      $.post($(this).data("update-url"), $(this).sortable('serialize'))

  $(".sortable-menu-children").sortable
    axis: "y"
    update: ->
      $.post($(this).data("update-url"), $(this).sortable('serialize'))
