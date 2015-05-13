jQuery ->
  return unless $("#stances_index").length
  new StanceController()

class StanceController
  constructor: ->
    @bindEvents()

  bindEvents: ->
    @saveStance()
    @updateStance()

  saveStance: ->
    $(".save_btn").on "click", (event) ->
      $button = $(event.target)
      id = $button.parents(".statement").data("statement_id")
      $.post "/stances",
        stance:
          agreeance_value: $("#agreeance_#{id}").val(),
          importance_value: $("#importance_#{id}").val(),
          statement_id: id,
        -> $button.text("Stance Saved!")

