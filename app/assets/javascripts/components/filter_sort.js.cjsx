@FilterSort = React.createClass
  render: ->
    React.DOM.div
      className: "col-md-4 filter_search"
      React.DOM.input
        ref: "searchField"
        type: "text"
        name: "directory_search"
        className: "search_field"
        placeholder: "Search by name"
        require: "true"
        onChange: @filterDirectory
      React.DOM.a
        className: "pull-right search_btn"
        title: "Search by name"
      React.DOM.br null
      React.DOM.br null
      React.DOM.strong null,
        React.DOM.select
          name: "sort_field"
          ref: "sortField"
          className: "form-control"
          onChange: @filterDirectory
          @filterOptions()

  filterOptions: ->
    @props.filterOptions.map (array, i) ->
      React.DOM.option
        value: array[1]
        key: i
        array[0]

  filterDirectory: (e) ->
    @props.filterDirectory
      search: React.findDOMNode(@refs.searchField).value
      sort: React.findDOMNode(@refs.sortField).value

