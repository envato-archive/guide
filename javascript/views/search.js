/**
 * Guide: autocomplet search
 */
var $ = require('jquery')
require('selectize')

var Search = function ($el) {
  this.$el = $el
  this.status = false
  this.dom = {
    $body: $('body'),
    $searchInput: $el.find('input'),
    $searchToggle: $el.find('.js-sg-search__toggle')
  }

  this.dom.$searchToggle.on('click', this.toggleSearch.bind(this))

  this.dom.$searchInput.selectize({
    closeAfterSelect: true,
    openOnFocus: false,
    maxItems: 1,
    maxOptions: 30,
    dataAttr: 'data-pages',
    sortField: 'value',
    searchField: 'label',
    labelField: 'label',
    valueField: 'value',
    onChange: function (value) {
      if (value !== '') {
        window.location = value
      }
    },
    onBlur: this.toggleSearch.bind(this)
  })

  this.selectize = this.dom.$searchInput[0].selectize
}

Search.prototype.toggleSearch = function () {
  this.status = !this.status
  this.dom.$body.attr('data-search', this.status)

  if (this.status === true) {
    this.selectize.enable()
    this.selectize.setValue('', false)
    this.selectize.focus()
  } else {
    this.selectize.disable()
  }
}

module.exports = Search
