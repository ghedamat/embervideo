App.MoviesListController = Em.ArrayController.extend
  sortProperties: ['score','title']
  sortAscending: false

  currentMovieBinding: 'controllers.moviesController.movie'

  setScores: ( ->
    unless @get('query') == undefined
      return @forEach (data,i) =>
        score = $.fuzzyMatch(data.get('title'), @get('query')).score
        data.set('score',score)
        return data
  ).observes('content','query')

  filteredMovies: ( ->
    if @get('query') == undefined
      return @
    else
      @filter (data) -> return data.get('score') > 0
  ).property('query','content')


