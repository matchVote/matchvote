jQuery ->
  return unless $("#directory_index").length
  new DirectoryController()

class DirectoryController
  constructor: () ->
    @$searchField = $("#directory_search_field")
    @$searchButton = $("#directory_search_button")
    @$sortField = $("#rep_sorter")
    @bindEvents()

  bindEvents: ->
    @clickToSearch()
    @pressEnterToSearch()
    @selectSort()

  clickToSearch: ->
    @$searchButton.click => @filterReps()

  pressEnterToSearch: ->
    $(document).on "keypress", (event) =>
      if @$searchField.is(":focus") and event.which == 13
        @filterReps()

  selectSort: ->
    @$sortField.change => @filterReps()

  filterReps: ->
    $.get "/directory/filter",
      search: @$searchField.val(),
      sort: @$sortField.val(),
      @showReps

  showReps: (html) ->
    $("#reps_container").html(html)

