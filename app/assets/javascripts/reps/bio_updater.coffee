$(document).on "page:change", ->
  $bioContainer = $("[data-role=biography_container]")
  new Rep.BioUpdater($bioContainer) if $bioContainer.length

class Rep.BioUpdater
  constructor: (@$bioContainer) ->
    @bioContainerTemp = ""
    @textArea = "[data-role=biography_text_area]"
    @party = "[data-role=party]"
    @status = "[data-role=status]"
    @governmentRole = "[data-role=government_role]"
    @state = "[data-role=state]"
    @bindEvents()

  bindEvents: ->
    @clickEditBioButton()
    @clickSaveBioButton()
    @clickCancelBioButton()

  clickEditBioButton: ->
    self = @
    @$bioContainer.on "click", "[data-behavior=edit_bio]", ->
      id = $(@).data("id")
      self.bioContainerTemp = self.$bioContainer.html()
      $.get "/representatives/#{id}/edit/biography", (html) ->
        self.$bioContainer.html(html)

  clickSaveBioButton: ->
    self = @
    @$bioContainer.on "click", "[data-behavior=save_bio]", ->
      id = $(@).data("id")
      $.post "/representatives/#{id}/edit/biography",
        self.collectInput(),
        (html) -> self.$bioContainer.html(html)

  clickCancelBioButton: ->
    @$bioContainer.on "click", "[data-behavior=cancel_bio]", =>
      @$bioContainer.html(@bioContainerTemp)

  collectInput: ->
    representative:
      biography: $(@textArea).val()
      party: $(@party).val()
      state: $(@state).val()
      status: $(@status).val()
      government_role: $(@governmentRole).val()

