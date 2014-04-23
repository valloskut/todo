App.controller 'ToDosCtrl', ['$scope', 'Todo', ($scope, Todo) ->
  $scope.todos = []
  $scope.newTodo = {}
  $scope.today = new Date()
  $scope.priorities = ['Highest', 'Very High', 'High', 'Above Average', 'Average', 'Below Average', 'Low', 'Very Low', 'Lowest']

  Todo.query {}, (data, headers) ->
    $scope.todos = data

  $scope.addTodo = ->
    window.alert 'add'

  $scope.open = ($event, todo) ->
    $event.preventDefault()
    $event.stopPropagation()
    #clear all open states
    for t in $scope.todos
      t.opened = false
    $scope.newTodo.opened = false
    todo.opened = true


]