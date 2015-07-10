jQuery ->
  new Rep.DemographicsUpdater() if $(".representatives.edit").length

class Rep.DemographicsUpdater
  constructor: ->
    @editButton = "[data-behavior=edit_demographics]"
    @cancelButton = "[data-behavior=cancel_demographics]"
    @saveButton = "[data-behavior=save_demographics]"
    @$demographicsContainer = $("#demographics")
    @demographicsHtml = @$demographicsContainer.html()
    @bindEvents()

  bindEvents: ->
    @clickEditButton()
    @clickCancelButton()
    @clickSaveButton()

  clickEditButton: ->
    self = @
    @$demographicsContainer.on "click", @editButton, (event) ->
      id = $(@).data("id")
      $.get "/representatives/#{id}/edit/demographics", (html) ->
        $("#demographics").html(html)
        App.attachDatepicker()

  clickCancelButton: ->
    self = @
    @$demographicsContainer.on "click", @cancelButton, ->
      self.$demographicsContainer.html(self.demographicsHtml)

  clickSaveButton: ->
    self = @
    @$demographicsContainer.on "click", @saveButton, ->
      id = $(@).data("id")
      $.post "/representatives/#{id}/edit/demographics",
        self.collectInput(),
        (html) -> self.$demographicsContainer.html(html)

  collectInput: ->
    representative:
      gender: $("#gender").val()

