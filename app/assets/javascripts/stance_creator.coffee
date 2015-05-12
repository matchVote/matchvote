jQuery ->
  return unless $("#stances_index").length
  new StanceCreator()

class StanceCreator
  constructor: ->
    @bindEvents()

  bindEvents: ->
    @saveStance()

  saveStance: ->
    $(".save_btn").click ->
      id = $(@).data("statement-id")
      $.post "/stances",
      stance:
        agreeance_value: $("#agreeance_#{id}").val(),
        importance_value: $("#importance_#{id}").val(),
        statement_id: id,
      -> $(@).text("Stance Saved!")

