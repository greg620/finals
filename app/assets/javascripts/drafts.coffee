$(document).ready ->
  $("#new_post").on("ajax:success", (e, data, status, xhr) ->
    $("#new_post").append xhr.responseText
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#new_post").append "<p>ERROR</p>"