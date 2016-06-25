jQuery ->
  $("form").on "click", ".add_fields", (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data("id"), "g")
    $(this).before($(this).data("fields").replace(regexp, time))
    event.preventDefault()

  $("form").on "click", ".remove_fields", (event) ->
    $(this).prev("input[type=hidden]").val("1")
    $(this).parent().parent().hide()
    event.preventDefault()

  $(".sortable").sortable
    axis: "y"
    update: ->
      $.post($(this).data("update-url"), $(this).sortable('serialize'))