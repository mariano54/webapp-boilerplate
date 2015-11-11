actionNames = require('../actions/actionNames')

class Foo
  changeText: (text) ->
    return (
      type:	actionNames.CHANGE_TEXT
      text: text
    )
module.exports = Foo
