$(document).on "page:change", ->
  StancesToggler.toggleStances() if $(".toggle_stances_link").length

class StancesToggler
  @toggleStances: ->
    $(".issue").on "show.bs.collapse", "section.collapse", (event) ->
      $(event.target).parent().children(".toggle_stances_link").text "Collapse"
    $(".issue").on "hide.bs.collapse", "section.collapse.in", (event) ->
      $(event.target).parent().children(".toggle_stances_link").text "Expand"

