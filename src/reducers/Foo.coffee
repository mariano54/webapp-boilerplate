actionNames = require('../actions/actionNames')

Foo =
  text: (state = "", action) ->
    switch action.type
      when actionNames.CHANGE_TEXT
        action.text
      else state

module.exports = Foo
