jQuery ->
  $bioContainer = $("[data-role=biography_container]")
  (new Rep.BioToggler($bioContainer)).toggle() if $bioContainer.length

class Rep.BioToggler
  constructor: (@$bioContainer) ->
    @shortBio = "#short_bio"
    @fullBio = "#full_bio"
    @$toggleButton = "[data-behavior=toggle_bio]"

  toggle: ->
    @$bioContainer.on "click", @toggleButton, =>
      if $(@shortBio).is(":visible")
        $(@fullBio).show()
        $(@shortBio).hide()
        $(@toggleButton).text("Less...")
      else
        $(@fullBio).hide()
        $(@shortBio).show()
        $(@toggleButton).text("Read Full Bio")

