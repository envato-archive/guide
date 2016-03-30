var $ = window.jQuery = require('jquery')

require('./vendor/modernizr')
require('./vendor/overthrow')
var viewloader = require('./vendor/viewloader')

var Layout = require('./views/layout')
var Iframe = require('./views/iframe')
var Search = require('./views/search')
var Scenario = require('./views/scenario')
var Navigation = require('./views/navigation')
var LanguageSwitcher = require('./views/languageSwitcher')

var Views = {}
Views.Layout = Layout
Views.Iframe = Iframe
Views.Search = Search
Views.Scenario = Scenario
Views.Navigation = Navigation
Views.LanguageSwitcher = LanguageSwitcher

viewloader.execute(Views)
