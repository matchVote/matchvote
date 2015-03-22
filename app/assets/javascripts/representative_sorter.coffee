jQuery ->
  return unless $("#rep_sorter").length
  new RepresentativeSorter()

class RepresentativeSorter
  constructor: ->
    @$selectBox = $("#rep_sorter")
    # @handleSort()

  handleSort: ->
    @$selectBox.change -> 
