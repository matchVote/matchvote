jQuery ->
  button = $("#directory_search_button")
  return unless button.length
  new DirectorySearch(button)

class DirectorySearch
  constructor: (@$searchButton) ->
    @$searchField = $("#directory_search_field")
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

