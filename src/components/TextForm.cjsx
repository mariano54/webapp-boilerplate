React = require 'react'
Input = require "react-bootstrap/lib/Input"

TextForm = React.createClass
  displayName: "TextForm"

  componentDidMount: () ->
    @onChangeText @refs.input.getValue()

  onChangeText: () ->
    @props.onChangeText @refs.input.getValue()

  render: ->
    return <div>
        {@props.instructions}
        <Input
          type='text'
          autoFocus={true}
          value={@props.value}
          placeholder='Enter phone number'
          help='Make sure the phone number is valid.'
          bsStyle={if @props.ready then "success" else "warning"}
          hasFeedback
          ref='input'
          groupClassName='group-class'
          labelClassName='label-class'
          onChange={@onChangeText} />
    </div>

module.exports = TextForm
