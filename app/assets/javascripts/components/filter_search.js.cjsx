@FilterSearch = React.createClass
  render: ->
    React.DOM.div
      className: "col-md-4 filter_search"
      React.DOM.input
        type: "text"
        name: "directory_search"
        id: "directory_search_field"
        className: "search_field"
        placeholder: "Search by name"
        require: "true"
      React.DOM.a
        id: "directory_search_button"
        className: "pull-right search_btn"
        title: "Search by name"
      React.DOM.br null
      React.DOM.br null
      React.DOM.strong null,
        React.DOM.select
          id: "rep_sorter"
          className: "form-control"
          @filterOptions()

    # <div className="col-md-4 filter_search">
    #   <input type="text" name="directory_search" id="directory_search_field" className="search_field" placeholder="Search by name" require="true">
    #   </input>
    #   <a id="directory_search_button" className="pull-right search_btn" title="Search by name">
    #     <span className="glyphicon glyphicon-search"></span>
    #   </a>
    #   <br/>
    #   <br/>
    #   <strong>
    #     <select id="rep_sorter" className="form-control">
    #       { @filterOptions() }
    #     </select>
    #   </strong>
    # </div>

  filterOptions: ->
    @props.filterOptions.map (array, i) ->
      return <option value={array[1]} key={i}>{array[0]}</option>

