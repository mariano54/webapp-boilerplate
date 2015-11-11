React = require 'react'
Button = require "react-bootstrap/lib/Button"
Radium = require 'radium'

styles =
  buttonLeft:
    marginRight: "10px"

Buttons = React.createClass
  displayName: "Buttons"
  render: ->
    return <div>
      <Button bsStyle="default" onClick={@props.onCancel} style={styles.buttonLeft}>Cancel</Button>
      <Button bsStyle="primary" onClick={@props.onSubmit} disabled={!@props.ready}>Submit</Button>
    </div>

module.exports = Radium(Buttons)
