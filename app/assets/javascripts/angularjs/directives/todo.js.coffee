App.directive 'todo', ['$document', ($document) ->
  restrict: "A"
  templateUrl: '/assets/angularjs/directives/templates/todo.html'
  scope:
    todo: '=ngModel'
    new: '='

]