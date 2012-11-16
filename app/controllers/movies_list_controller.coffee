App.MoviesListController = Em.ArrayController.extend
  sortProperties: ['score','title']
  sortAscending: false
  limit: 10
  maxLimitBinding: 'length'

  currentMovieBinding: 'controllers.moviesController.movie'

  filteredMovies: ( ->
    if @get('query') == undefined
      @filter (data,i) => return (i < @get('limit'))
    else
      @forEach (data,i) =>
        score = $.fuzzyMatch(data.get('title'), @get('query')).score
        data.set('score',score)
      @filter((data,i) -> return (data.get('score') > 0))
      .filter((data,i) => return (i < @get('limit')))
  ).property('content.isLoaded','query','limit')


