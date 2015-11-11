# Libraries
React = require 'react'
ReactDOM = require 'react-dom'
CM = require "./services/Mixins"
CM.bootstrap()
_ = require "underscore"
createStore = require('redux').createStore
applyMiddleware = require('redux').applyMiddleware
compose = require('redux').compose
combineReducers = require('redux').combineReducers
Provider =  require('react-redux').Provider
connect =  require('react-redux').connect

# Development tools
persistState = require('redux-devtools').persistState
createDevTools = require('redux-devtools').createDevTools
LogMonitor = require 'redux-devtools-log-monitor'
LogMonitor = require 'redux-devtools-log-monitor'
DockMonitor = require 'redux-devtools-dock-monitor'


#Routing
Route = require('react-router').Route
ReduxRouter = require('redux-router').ReduxRouter
reduxReactRouter = require('redux-router').reduxReactRouter
routes = require('./routes').routes
createHistory = require('history/lib/createBrowserHistory')

# Components and reduceers
reducer = require('./reducers/reducers')


# MIDDLEWARE
logger = (store) ->
  (next) ->
    (action) ->
      if debug then console.log 'dispatching', action
      result = next action
      if debug then console.log '\tnext state', store.getState()
      result

thunk = (store) ->
  (next) ->
    (action) ->
      if !_.isFunction action then next action
      else action(next, store.getState())


# Create the devTools
DevTools = createDevTools(
  <DockMonitor toggleVisibilityKey='H'
               changePositionKey='Q'>
    <LogMonitor />
  </DockMonitor>
)

store = compose(
  applyMiddleware(thunk, logger),
  reduxReactRouter({
    routes
    createHistory
  }),
  DevTools.instrument()
  persistState(
    window.location.href.match(
      /[?&]debug_session=([^&]+)\b/
    )
  )
)(createStore)(reducer)

ReactDOM.render((
  <div>
    <Provider store={store}>
      <div>
        <DevTools />
        <ReduxRouter />
      </div>
    </Provider>
  </div>
), document.getElementById("react"))
