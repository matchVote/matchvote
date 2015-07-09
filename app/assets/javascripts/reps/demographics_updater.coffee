jQuery ->
  new Rep.DemographicsUpdater() if $(".representatives.edit").length

class Rep.DemographicsUpdater
  constructor: ->
    @editButton = "[data-behavior=edit_demographics]"
    @cancelButton = "[data-behavior=cancel_demographics]"
    @$demographicsContainer = $("#demographics")
    @demographicsHtml = @$demographicsContainer.html()
    @bindEvents()

  bindEvents: ->
    @clickEditButton()
    @clickCancelButton()

  clickEditButton: ->
    self = @
    @$demographicsContainer.on "click", @editButton, (event) ->
      id = $(event.target).data("id")
      $.get "/representatives/#{id}/edit/demographics", (html) ->
        $("#demographics").html(html)
        App.attachDatepicker()

  clickCancelButton: ->
    @$demographicsContainer.on "click", @cancelButton, =>
      $("#demographics").html(@demographicsHtml)

