/**
 * Guide: Navigation
 */
require('../vendor/tendina')

var Navigation = function ($el) {
  $el.tendina({
    activeMenu: '.is-active',
    speed: 300
  })
}

module.exports = Navigation
