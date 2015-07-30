@FilterSearch = React.createClass
  render: ->
    React.DOM.div
      className: "col-md-4 filter_search"
      React.DOM.input
        type: "text"
        name: "directory_search"
        className: "search_field"
        placeholder: "Search by name"
        require: "true"
        onChange: @searchDirectory
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

  filterOptions: ->
    @props.filterOptions.map (array, i) ->
      return <option value={array[1]} key={i}>{array[0]}</option>

  searchDirectory: (e) ->
    @props.searchDirectory(event.target.value)

