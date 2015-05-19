jQuery ->
  return unless $("#stances_index").length
  new StanceController()

class StanceController
  constructor: ->
    @$saveButton = null
    @bindEvents()

  bindEvents: ->
    @saveStance()
    @updateStance()

  saveStance: ->
    $(".stance_button").on "click", ".save_btn", (event) =>
      @$saveButton = $(event.target)
      id = @$saveButton.parents(".statement").data("statementId")
      $.post "/stances",
        stance:
          agreeance_value: $("#agreeance_#{id}").val(),
          importance_value: $("#importance_#{id}").val(),
          statement_id: id,
        @displayUpdateButton

  displayUpdateButton: (html) =>
    @$saveButton.text("Stance saved!")
    $stanceButton = @$saveButton.parent()
    setTimeout (=> $stanceButton.html(html)), 1500

  updateStance: ->
    $(".stance_button").on "click", ".update_btn", (event) =>
      @$updateButton = $(event.target)
      statementId = @$updateButton.parents(".statement").data("statementId")
      stanceId = @$updateButton.data("stanceId")
      $.ajax {
        type: "PATCH",
        url: "/stances/#{stanceId}",
        data:
          stance:
            agreeance_value: $("#agreeance_#{statementId}").val(),
            importance_value: $("#importance_#{statementId}").val()
        success: =>
          @$updateButton.text("Stance updated!")
          setTimeout (=> @$updateButton.text("Update Stance")), 1500 }
      
