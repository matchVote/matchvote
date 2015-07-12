jQuery ->
  (new Rep.BioToggler).toggle() if $(".representatives.show").length

class Rep.BioToggler
  constructor: ->
    @$short_bio = $("#short_bio")
    @$full_bio = $("#full_bio")
    @$button = $("#read_full_bio")

  toggle: ->
    @$button.click =>
      if @$short_bio.is(":visible")
        @$full_bio.show()
        @$short_bio.hide()
        @$button.text("Less...")
      else
        @$full_bio.hide()
        @$short_bio.show()
        @$button.text("Read Full Bio")

