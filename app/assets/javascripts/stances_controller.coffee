jQuery ->
  return unless $("#stances_index").length
  new StancesController()

class StancesController
  constructor: ->
    @bindEvents()

  bindEvents: ->
    @saveStance()
    @updateStance()
    @deleteStance()

  saveStance: ->
    $(".statement").on "click", ".save_btn", (event) =>
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
    $(".statement").on "click", ".update_btn", (event) =>
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
      
  deleteStance: ->
    $(".statement").on "click", ".delete_btn", (event) =>
      @$deleteButton = $(event.target)
      statementId = @$deleteButton.parents(".statement").data("statementId")
      stanceId = @$deleteButton.data("stanceId")
      $.ajax {
        type: "DELETE",
        url: "/stances/#{stanceId}",
        success: (html) ->
          $(".statement[data-statement-id='#{statementId}']").html(html) }

