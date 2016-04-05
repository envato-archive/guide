var test = require('tape')
var $ = require('jquery')

var Layout = require('../views/layout')

test('Layout View', function (t) {
  $('body').append(`<div data-view="layout">
    <div class="js-layout__nav-toggle"></div>
    <div class="js-layout__nav-overlay"></div>
  </div>`)

  var el = $('body').find('[data-view]')[0]
  var layoutView = new Layout($(el))

  t.test('when click toggle div', function (assert) {
    layoutView.dom.$toggle.trigger('click')
    var expected = 'enabled'
    var actual = $('body').attr('data-off-canvas')
    assert.equal(expected, actual, 'should open nav')
    assert.end()
  })

  t.test('when click overlay', function (assert) {
    layoutView.dom.$overlay.trigger('click')
    var expected = 'disabled'
    var actual = $('body').attr('data-off-canvas')
    assert.equal(expected, actual, 'should close nav')
    assert.end()
  })
})
