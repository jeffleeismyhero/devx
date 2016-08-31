$ ->
  $("form").on "click", ".add_fields", (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data("id"), "g")
    $(this).parent().children(".nested-attributes").append($(this).data("fields").replace(regexp, time))
    event.preventDefault()

    # Remove each select2 element before adding them again
    $selects = $('.select2, .select2-multiple, .select2-multiple-fixed, .select2-fixed').select2()
    $selects.each (i, item) ->
      $(item).select2("destroy")

    $(".select2").select2({ tags: true });
    $(".select2-multiple").select2({ tags: true, multiple: true });
    $(".select2-multiple-fixed").select2({ tags: false, multiple: true });
    $(".select2-fixed").select2({ tags: false, multiple: false });
    $('.datepicker').datetimepicker({timepicker: false, format: 'm/d/Y'});
    $('.timepicker').timepicker({
      'timeFormat': 'g:i a',
      'step': 15,
      'selectOnBlur': false,
      'scrollDefaultNow': true,
      'forceRoundTime': false
    });

  $("form").on "click", ".remove_fields", (event) ->
    $(this).prev("input[type=hidden]").val("1")
    $(this).parent().parent().hide()
    event.preventDefault()

  $(".sortable-list").sortable
    axis: "y"
    update: ->
      console.log($(this).sortable("serialize"))
      $.post($(this).data("update-url"), $(this).sortable("serialize"))

  $(".sortable-menu").sortable
    axis: "y"
    update: ->
      $.post($(this).data("update-url"), $(this).sortable('serialize'))

  $(".sortable-menu-children").sortable
    axis: "y"
    update: ->
      $.post($(this).data("update-url"), $(this).sortable('serialize'))
