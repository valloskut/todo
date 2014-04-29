App.controller 'ToDosCtrl', ['$scope', 'Todo', ($scope, Todo) ->
  $scope.todos = []
  $scope.newTodo = {}
  $scope.today = new Date()

  $scope.loadTodos = ->
    Todo.query {}, (data, headers) ->
      $scope.todos = data

  $scope.uncompleted = (todo) ->
    !todo.completed

  $scope.$on 'todo_added', (event, todo) ->
    $scope.todos.push todo
    $scope.newTodo = {}
  $scope.$on 'todo_saved', (event, todo) ->
    console.log "todo '#{todo.title}' saved successfully"
  $scope.$on 'todo_deleted', (event, todo) ->
    $scope.todos.splice($scope.todos.indexOf(todo), 1)
  # Initial todos
  $scope.loadTodos()
]