# Libraries
React = require 'react'
Radium = require 'radium'

#Custom files
actions = require '../actions/actions'

Root = React.createClass
  displayName: "Root"

  componentWillMount: ->
    @d = @props.dispatch

  render: ->
    <span>
      {@props.children}
    </span>

module.exports = Root
