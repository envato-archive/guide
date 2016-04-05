/**
 * Guide: Language Switcher
 */
var LanguageSwitcher = function ($el) {
  this.$el = $el

  this.$select = $el.find('.js-gudie__language')
  this.$select.on('change', this.handleChange.bind(this))
}

LanguageSwitcher.prototype.handleChange = function () {
  this.$el.submit()
}

module.exports = LanguageSwitcher
