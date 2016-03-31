/**
 * Guide: Layout
 */
var $ = require('jquery')

var Layout = function ($el) {
  this.$el = $el

  this.dom = {
    $body: $('body'),
    $toggle: $el.find('.js-layout__nav-toggle'),
    $overlay: $el.find('.js-layout__nav-overlay')
  }

  this.dom.$overlay.on('click', this.closeNav.bind(this))
  this.dom.$toggle.on('click', this.openNav.bind(this))
}

Layout.prototype.closeNav = function () {
  this.dom.$body.attr('data-off-canvas', 'disabled')
}

Layout.prototype.openNav = function () {
  this.dom.$body.attr('data-off-canvas', 'enabled')
}

module.exports = Layout
