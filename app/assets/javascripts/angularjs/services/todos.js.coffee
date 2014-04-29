App.factory 'Todo', ['$resource', ($resource) ->
  $resource '/api/v1/to_dos/:id',
    {
      id: '@id',
    }, {
    update: {method: 'PUT'}
    }
]
