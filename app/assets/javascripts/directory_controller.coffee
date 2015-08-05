$(document).on "page:change", ->
  # return unless $("#directory_index").length
  # new DirectoryController()

class DirectoryController
  constructor: ->
    @$searchField = $("#directory_search_field")
    @$searchButton = $("#directory_search_button")
    @$sortField = $("#rep_sorter")
    @$repsContainer = $("#reps_container")
    @pageCount = 2
    @bindEvents()

  bindEvents: ->
    @clickToSearch()
    @pressEnterToSearch()
    @selectSort()
    @pagination()

  clickToSearch: -> @$searchButton.click => @filterReps()

  pressEnterToSearch: ->
    $(document).on "keypress", (event) =>
      if @$searchField.is(":focus") and event.which == 13
        @filterReps()

  selectSort: -> @$sortField.change => @filterReps()

  filterReps: ->
    $.get "/directory/filter",
      search: @$searchField.val(),
      sort: @$sortField.val(),
      @showReps

  showReps: (html) => @$repsContainer.html(html)

  appendReps: (html) =>
    $(".pagination").remove()
    @$repsContainer.append(html)

  pagination: ->
    $(window).scroll =>
      if $(window).scrollTop() is $(document).height() - $(window).height()
        href = $(".pagination .next_page").attr("href")
        @paginateFilter(@extractParams(href)) if href

  paginateFilter: (params) ->
    $.get "/directory/filter",
      search: params.search,
      sort: params.sort,
      page: params.page,
      @appendReps

  extractParams: (url) ->
    params = url.split("?")[1].split("&")
    params.reduce ((acc, param) ->
      keyValue = param.split("=")
      acc[keyValue[0]] = keyValue[1]
      acc
    ), {}

