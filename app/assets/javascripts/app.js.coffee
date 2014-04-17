window.App = angular.module('ToDo',['ngResource'])

App.config ["$locationProvider", ($locationProvider) ->
    $locationProvider.html5Mode(true)
  ]