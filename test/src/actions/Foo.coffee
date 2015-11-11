expect = require('chai').expect

CM = require "../../../public/services/Mixins"
CM.bootstrap()

actions =  require '../../../public/actions/actions'
actionNames = require '../../../public/actions/actionNames'

describe 'Foo Action creator', () ->
  it 'should dispatch an action to change the text', () ->
    expectedAction =
      type: actionNames.CHANGE_TEXT
    expect(actions.changeText()).type.equal expectedAction.type
