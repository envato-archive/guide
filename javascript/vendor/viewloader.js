var $ = require('jquery')

function capitaliseFirstLetter (string) {
  return string.charAt(0).toUpperCase() + string.slice(1)
}

var viewloader = {
  execute: function (Views, $scope) {
    var $els = $scope ? $scope.find('[data-view]') : $('[data-view]')

    if ($els.length) {
      $els.each(function (i, el) {
        var $el = $(el)
        var view = capitaliseFirstLetter($el.data('view'))

        if (view && Views[view]) {
          return new Views[view]($el, el)
        }
      })
    }
  }
}

module.exports = viewloader
