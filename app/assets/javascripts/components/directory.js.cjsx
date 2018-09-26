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
    <div className="container">
      <div className="filter_menu">
        <div className="col-md-8">
          <h3>Find elected officials to follow</h3>
          <h5>
            { @props.filterCount } elected officials meet your search criteria.
            Add filters to refine your search.
          </h5>
          <div className="well well-sm filter_well">
            <a className="btn btn-default disabled">
              <span className="glyphicon glyphicon-minus-sign"></span>
              &nbsp;Federal
            </a>
            <a className="btn btn-default">
              <span className="glyphicon glyphicon-minus-sign"></span>
              &nbsp;In Office
            </a>
            <a className="btn btn-danger pull-right" onClick={@underDevelopment}>
              <span className="glyphicon glyphicon-plus-sign"></span>
              &nbsp;Add Filter
            </a>
          </div>
        </div>
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

  underDevelopment: ->
    swal 'Under Development', "We're currently working to implement this feature."
