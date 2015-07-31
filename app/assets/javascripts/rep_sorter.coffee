class App.RepSorter
  constructor: (@reps) ->

  popularity: ->
    @reps.sort (a, b) => @sort(b.name_recognition, a.name_recognition)

  alphabetically: ->
    @reps.sort (a, b) => @sort(a.last_name, b.last_name)

  age: ->
    @reps.sort (a, b) => @sort(b.birthday, a.birthday)

  seniority: ->
    @reps.sort (a, b) => @sort(a.seniority_date, b.seniority_date)

  state: ->
    @reps.sort (a, b) => @sort(a.state, b.state)

  similarity: ->
    @reps.sort (a, b) => @sort(b.overall_match_percent, a.overall_match_percent)

  difference: ->
    @reps.sort (a, b) => @sort(a.overall_match_percent, b.overall_match_percent)

  approval: ->
    swal "", "Not implemented"
    @reps

  sort: (value1, value2) ->
    if value1 < value2
      -1
    else if value1 > value2
      1
    else
      0

