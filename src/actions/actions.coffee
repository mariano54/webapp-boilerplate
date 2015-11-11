_ = require 'underscore'

# This automatically requires all other action files
otherActions = _.filter require('./*', {mode: 'list'}), (o) ->
  o.name != 'actions' and o.name != 'actionNames'

class Actions
  for file in otherActions
    @include file.module

module.exports = new Actions()
