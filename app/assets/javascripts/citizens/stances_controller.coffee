$(document).on "page:change", ->
  return unless $("#edit_citizen_stances").length
  new CitizenStancesController()

class CitizenStancesController
  constructor: ->
    @bindEvents()

  bindEvents: ->
    @updateStance()
    @deleteStance()

  updateStance: ->
    $(".update_btn").click ->
      stanceId = $(@).data("stanceId")
      $.ajax
        type: "PATCH",
        url: "/stances/#{stanceId}",
        data:
          stance:
            agreeance_value: $("#agreeance_#{stanceId}").val(),
            importance_value: $("#importance_#{stanceId}").val()
        success: =>
          $(@).text("Stance updated!")
          setTimeout (=> $(@).text("Update")), 1500

  deleteStance: ->
    self = @
    $(".delete_btn").click ->
      $stance = $(@).parents(".stance")
      $.ajax
        type: "DELETE",
        url: "/stances/#{$stance.data("stanceId")}",
        success: => self.removeStance($stance)

  removeStance: ($stance) ->
    $issue = $stance.parents(".issue")
    stanceCount = $issue.children("section").children(".stance").length
    if stanceCount is 1 then $issue.remove() else $stance.remove()

