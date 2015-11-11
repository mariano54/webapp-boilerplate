# Libraries
React = require 'react'
connect =  require('react-redux').connect
Radium = require 'radium'

# Components
TextForm = require '../components/TextForm'
Buttons = require '../components/Buttons'

# Custom files
actions = require("../actions/actions")

Foo = React.createClass
  displayName: "Foo"
  instructions: "Please enter your name to continue."

  componentDidMount: ->
    document.addEventListener('keydown', @onKeyDown)
  componentWillUnmount: ->
    document.removeEventListener('keydown', @onKeyDown)
  onKeyDown: (event) ->
    if event?.which == 13 then @onSubmit()

  componentWillMount: ->
    @d = @props.dispatch

  onSubmit: ->
    console.log "Submitted"
  onCancel: ->
    console.log "Cancelled"

  onChangeText: (text) ->
    @d actions.changeText(text)

  render: ->
    <div>
      <TextForm instructions={@instructions} onChangeText={@onChangeText} ready={@props.ready}/>
      <Buttons onSubmit={@onSubmit} onCancel={@onCancel} ready={@props.ready}/>
    </div>


select = (state) ->
  return(
    name: state.Foo.text
    ready: state.Foo.text.length>5
  )

module.exports = connect(select)(Radium(Foo))
