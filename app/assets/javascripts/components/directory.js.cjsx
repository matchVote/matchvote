@Directory = React.createClass
  increment: 50

  getInitialState: ->
    reps: []
    multiplier: 1
    filter: null
    sort: "popularity"

  componentWillMount: ->
    reps = @filterReps({filter: null, sort: @state.sort})
    @setState
      reps: @paginate(reps, @state.multiplier)

  componentDidMount: ->
    @startScrollingPagination()

  render: ->
    <div className="directory_index">
      <div className="filter_menu">
        <div className="col-md-7">
          <h2>Find elected officials to follow</h2>
          <h5>
            We'll keep you up to date with the news and political positions of the
            those you choose to follow.
          </h5>
          <h5>
            { @props.filterCount } elected officials meet your search criteria.
            Add more filters to refine your search.
          </h5>
          <div className="well well-sm filter_well">
            <a className="btn btn-default disabled">
              <div className="glyphicon glyphicon-remove"></div>
              Federal
            </a>
            <a className="btn btn-default">
              <div className="glyphicon glyphicon-remove"></div>
              In Office
            </a>
            <a className="btn btn-danger pull-right">
              <div className="glyphicon glyphicon-plus"></div>
              Add Filter
            </a>
          </div>
        </div>
        <div className="col-md-1"></div>
        <FilterSort filterOptions={@props.sortList} filterDirectory={@filterDirectory}/>
      </div>
      <div id="reps_container" className="row">
        { for rep in @state.reps
            <Representative key={rep.id} rep={rep}/> }
      </div>
    </div>

  # Callbacks

  filterDirectory: (params) ->
    @setState
      filter: params.filter
      sort: params.sort
      multiplier: 1
      reps: @paginate(@filterReps(params), 1)

  # Helpers

  filterReps: (params) ->
    filteredReps = @searchDirectory(@props.reps, params.filter)
    @sortDirectory(filteredReps, params.sort)

  searchDirectory: (reps, query) ->
    reps.filter (rep) => @repNames(rep).match(new RegExp(query, "i"))

  sortDirectory: (reps, sortType) -> new App.RepSorter(reps)[sortType]()

  repNames: (rep) ->
    rep.first_name + rep.last_name + rep.middle_name +
      rep.nickname + rep.official_full_name

  startScrollingPagination: ->
    $(window).scroll =>
      if $(window).scrollTop() is $(document).height() - $(window).height()
        multiplier = @state.multiplier + 1
        reps = @filterReps({filter: @state.filter, sort: @state.sort})
        @setState
          multiplier: multiplier
          reps: @paginate(reps, multiplier)

  paginate: (reps, multiplier) ->
    reps.slice(0, @increment * multiplier)

