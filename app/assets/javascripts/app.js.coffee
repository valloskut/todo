window.App = angular.module('ToDo',['ngResource', 'ui.bootstrap'])

App.config ["$locationProvider", ($locationProvider) ->
    $locationProvider.html5Mode(true)
  ]