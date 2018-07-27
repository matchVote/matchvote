window.App ||= {}
window.Rep ||= {}
window.Citizen ||= {}

App.attachDatepicker = ->
  $("#newsfeed-datepicker").datepicker
    todayHighlight: true
    multidate: true

App.init = ->
  App.attachDatepicker()

$(document).on "page:change", ->
  App.init()
