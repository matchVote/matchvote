jQuery ->
  return unless $("#stances_index").length
  new StanceController()

class StanceController
  constructor: ->
    @$saveButton = null
    @bindEvents()

  bindEvents: ->
    @saveStance()
    # @updateStance()

  saveStance: ->
    $(".stance_button").on "click", ".save_btn", (event) =>
      @$saveButton = $(event.target)
      id = @$saveButton.parents(".statement").data("statement_id")
      $.post "/stances",
        stance:
          agreeance_value: $("#agreeance_#{id}").val(),
          importance_value: $("#importance_#{id}").val(),
          statement_id: id,
        @displayButton

  displayButton: (html) =>
    @$saveButton.text("Stance saved!")
    $stanceButton = @$saveButton.parent()
    setTimeout (=> $stanceButton.html(html)), 2000

