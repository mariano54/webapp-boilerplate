combineReducers = require('redux').combineReducers
routerStateReducer = require('redux-router').routerStateReducer
_ = require('underscore')

# This makes a combined reducer given a file with a bunch of reducer functions
makeReducer = (file) ->
  return (state = {}, action) ->
    obj = {}
    for methodName of file.module
      if methodName == "__super__" or methodName == "include" then continue
      obj[methodName] = file.module[methodName] state[methodName], action
    obj

# Get all of the reducer files in this directory, into an array
otherReducers = _.filter require('./*', {mode: 'list'}), (o) -> o.name != 'reducers'

# Process all of these files into an object of reducers
otherReducersHash = {}
for file in otherReducers
  otherReducersHash[file.name] = makeReducer file

# Combine this with the other reducers
module.exports = combineReducers(_.extend otherReducersHash, {router: routerStateReducer})
