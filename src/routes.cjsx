# Libraries
React = require 'react'
Router = require('react-router').Router
Route = require('react-router').Route
IndexRoute = require('react-router').IndexRoute
_ = require 'underscore'

# Components and reduceers
Root = require('./containers/Root')
Foo = require('./containers/Foo')

#services
actions = require './actions/actions'


# This gets called whenever a route transition happens
onEnter = (nextState, replaceState) ->
  path = nextState.location.pathname
  console.log "Route change activated to:", path

  if path == '/Foo'
    replaceState null, '/Foo'


# This is where all the routes are defined for the popup
Routes = (
  <Route path="/" component={Foo} onEnter={onEnter}/>
  <IndexRoute component={Foo} onEnter={onEnter}/>
)
# Create the routes with the root component on the outside, and all the innerRoutes
# routes on the inside
routes = (
  <Route path="/" component={Root}>
    {Routes}
  </Route>
)

module.exports =
  routes: routes
