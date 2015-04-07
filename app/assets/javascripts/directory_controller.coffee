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

  clickToSearch: ->
    @$searchButton.click => @performSearch()

  pressEnterToSearch: ->
    $(document).on "keypress", (event) =>
      if @$searchField.is(":focus") and event.which == 13
        @performSearch()

  performSearch: ->
    $.get "/directory/search",
      search: @$searchField.val(),
      sort: @$sortField.val(),
      @showReps

  showReps: (html) ->
    $("#reps_container").html(html)

