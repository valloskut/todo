App.directive 'todoItem', ->
  restrict: "A"
  templateUrl: '/assets/angularjs/directives/templates/todo.html'
  scope:
    todo: '='
    new: '='
  link: ($scope, element, attrs) ->
    element.addClass 'todo'
    $scope.placeholder = attrs.placeholder || 'Todo title'

  controller: ($scope, Todo) ->
    $scope.change = ->
      $scope.changed = true

    $scope.todoID = (todo) ->
      if todo.id then todo.id else 'new-todo'

    $scope.checkTodo = (todo) ->
      check = (angular.isString(todo.title) && todo.title.length > 0)
      !check

    $scope.addTodo = (todo) ->
      Todo.save todo, (success) ->
        $scope.$emit 'todo_added', success
      , (error) ->
        console.log error.data.error

    $scope.saveTodo = (todo) ->
      Todo.update {id: todo.id, to_do: todo}, (success) ->
        $scope.$emit 'todo_saved', todo
        $scope.changed = false
      , (error) ->
        console.log error.data.error

    $scope.deleteTodo = (todo) ->
      Todo.delete id: todo.id, (success) ->
        $scope.$emit 'todo_deleted', todo
      , (error) ->
        console.log error.data.error


