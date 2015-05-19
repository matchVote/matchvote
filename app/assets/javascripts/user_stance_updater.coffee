jQuery ->
  return unless $("#edit_stances").length
  new UserStanceUpdater()

class UserStanceUpdater
  constructor: ->
    @bindEvents()

  bindEvents: ->
    @updateStance()

  updateStance: ->
    $(".update_btn").click ->
      stanceId = $(@).data("stanceId")
      $.ajax {
        type: "PATCH",
        url: "/stances/#{stanceId}",
        data:
          stance:
            agreeance_value: $("#agreeance_#{stanceId}").val(),
            importance_value: $("#importance_#{stanceId}").val()
        success: =>
          $(@).text("Stance updated!")
          setTimeout (=> $(@).text("Update Stance")), 1500 }
