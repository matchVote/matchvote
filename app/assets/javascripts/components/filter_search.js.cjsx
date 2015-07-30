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
        className: "pull-right search_btn"
        title: "Search by name"
      React.DOM.br null
      React.DOM.br null
      React.DOM.strong null,
        React.DOM.select
          className: "form-control"
          onChange: @sortDirectory
          @filterOptions()

  filterOptions: ->
    @props.filterOptions.map (array, i) ->
      React.DOM.option
        value: array[1]
        key: i
        array[0]

  searchDirectory: (e) ->
    @props.searchDirectory(e.target.value)

  sortDirectory: (e) ->
    @props.sortDirectory(e.target.value)

