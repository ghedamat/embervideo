App.MoviesListController = Em.ArrayController.extend
  sortProperties: ['score','title']
  sortAscending: false

  currentMovieBinding: 'controllers.moviesController.movie'

  filteredMovies: ( ->
    if @get('query') == undefined
      @
    else
      @forEach (data,i) =>
        score = $.fuzzyMatch(data.get('title'), @get('query')).score
        data.set('score',score)
      @filter (data) -> return data.get('score') > 0
  ).property('query')


