App.controller 'ToDosCtrl', ['$scope', 'Todo', ($scope, Todo) ->
  $scope.todos = []
  $scope.newTodo = {}
  $scope.today = new Date()

  Todo.query {}, (data, headers) ->
    $scope.todos = data

  $scope.addTodo = ->
    console.log 'add'

  $scope.checkTodo = (todo) ->
    title_length = (todo.title.length == 0)
    title_length
]