jQuery ->
  return
  # return unless $("#rep_sorter").length
  # new RepresentativeSorter()

class RepresentativeSorter
  constructor: ->
    @$selectBox = $("#rep_sorter")
    @handleSort()

  handleSort: ->
    self = @
    @$selectBox.change ->
      $.get("/directory/sort_reps", { sort: @value }, self.showReps)

  showReps: (html) ->
    html = if html then html else "Not Implemented"
    $("#reps_container").html(html)

