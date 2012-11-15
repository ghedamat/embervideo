App.MoviesListController = Em.ArrayController.extend
  sortProperties: ['score','title']
  sortAscending: false

  currentMovieBinding: 'controllers.moviesController.movie'

  setScores: (()->
    if @get('query') == undefined
      return @get('content')
    else
      co=  @get('content').forEach (data,i) =>
        score = $.fuzzyMatch(data.get('title'), @get('query')).score
        data.set('score',score)
        return data
      return co
  ).observes('content','query')


