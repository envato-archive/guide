/**
 * Guide: iFrame
 */
var $ = require('jquery')
var iFrameResize = require('iframe-resizer')

var Iframe = function ($el) {
  this.$el = $el

  iFrameResize.iframeResizer({
    resizedCallback: function (messageData) {
      // Specify which iframe to target
      var iframeId = messageData.iframe.id
      var $currentIframe = $('#' + iframeId)
      $currentIframe.parent().removeClass('is-loading')
    }
  }, $el.find('iframe')[0])
}

module.exports = Iframe
