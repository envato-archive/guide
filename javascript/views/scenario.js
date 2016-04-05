/**
 * Guide: Scenario
 */
var $ = require('jquery')
var URI = require('urijs')

var Scenario = function ($el) {
  this.$el = $el

  this.BREAKPOINT = {
    PHONE: '350px',
    TABLET: '750px',
    DESKTOP: '100%'
  }

  this.dom = {
    $container: $el.find('.js-guide__scenario-container'),
    $language: $el.find('.js-guide__scenario-locale'),
    $phone: $el.find('.js-guide__responsive-phone'),
    $tablet: $el.find('.js-guide__responsive-tablet'),
    $desktop: $el.find('.js-guide__responsive-desktop')
  }

  this._resizeFromParams()

  /**
   * Event Listeners
   */
  this.dom.$phone.on('click', this.resizePhone.bind(this))
  this.dom.$tablet.on('click', this.resizeTablet.bind(this))
  this.dom.$desktop.on('click', this.resizeDesktop.bind(this))
  this.dom.$language.on('change', this.updateLanguage.bind(this))
}

/**
 * Event Functions
 */
Scenario.prototype.resizePhone = function (e) {
  e.preventDefault()
  this._resize('phone')
}

Scenario.prototype.resizeTablet = function (e) {
  e.preventDefault()
  this._resize('tablet')
}

Scenario.prototype.resizeDesktop = function (e) {
  e.preventDefault()
  this._resize('desktop')
}

Scenario.prototype.updateLanguage = function (e) {
  var $iframe = this.dom.$container.find('iframe')
  var locale = $(e.target).val()
  var src = $iframe.attr('src')

  var uri = new URI(src)
  var newUrl = uri.search({
    temp_locale: locale
  })

  $iframe.attr('src', newUrl)
}

/**
 * Private Functions
 */
Scenario.prototype._resizeFromParams = function () {
  var uri = new URI(window.location)
  var breakpoint = uri.search(true)['breakpoint']

  if (typeof breakpoint !== 'undefined' && breakpoint !== null) {
    this._resize(breakpoint)
  }
}

Scenario.prototype._resize = function (breakpoint) {
  var width

  switch (breakpoint) {
    case 'phone':
      width = this.BREAKPOINT.PHONE
      break
    case 'tablet':
      width = this.BREAKPOINT.TABLET
      break
    case 'desktop':
      width = this.BREAKPOINT.DESKTOP
      break
    default:
      width = '100%'
  }

  this.dom.$container.css('width', width)
}

module.exports = Scenario
