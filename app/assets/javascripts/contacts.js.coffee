$(document).on "keypress", "#search", ->
  $("#contact-results").html("")

  $.get "/contacts/autocomplete",
    name: $("#search").val(),
    ((data) ->
      count = 0

      while count <= data.length - 1
        contact = data[count]
        $("#contact-results").append("<li>#{contact.name} - #{contact.number}</li>")
        count++
      ), "json"
