App.directive 'todo', ->
  restrict: "AEC"
  templateUrl: '/assets/angularjs/directives/templates/todo.html'
  scope:
    todo: '=ngModel'
    new: '='