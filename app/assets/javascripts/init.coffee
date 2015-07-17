window.App ||= {}
window.Rep ||= {}
window.Citizen ||= {}

App.attachDatepicker = ->
  $("#date_picker").datepicker
    autoclose: true
    startView: 2

App.init = ->
  App.attachDatepicker()

$(document).on "page:change", ->
  App.init()

