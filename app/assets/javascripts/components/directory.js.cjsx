@Directory = React.createClass
  getInitialState: ->
    reps: @props.reps

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
        <FilterSearch filterOptions={@props.sortList} searchDirectory={@searchDirectory}/>
      </div>
      <div id="reps_container" className="row">
        { for rep in @state.reps
            <Representative key={rep.id} rep={rep}/> }
      </div>
    </div>

  searchDirectory: (query) ->
    regex = new RegExp(query, "i")
    @setState reps: @props.reps.filter (rep) =>
      @repNames(rep).match(regex)

  repNames: (rep) ->
    rep.first_name + rep.last_name + rep.middle_name +
      rep.nickname + rep.official_full_name

