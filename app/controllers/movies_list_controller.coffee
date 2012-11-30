App.MoviesListController = Em.ArrayController.extend
  currentLetter: 'ALL'

  #limit: 10
  #maxLimitBinding: 'length'



  filteredMovies: ( ->
    res = @
    unless @get('currentLetter') == 'ALL'
      res = res.filter (data,i) =>
        (@get('currentLetter') == data.get('title')[0]) || (@get('currentLetter').toLowerCase() == data.get('title')[0])
    if @get('query') == undefined
      res = res.filter (data,i) -> return true
      #@filter (data,i) => return (i < @get('limit'))
    else
      res.forEach (data,i) =>
        score = $.fuzzyMatch(data.get('title'), @get('query')).score
        data.set('score',score)
      res = res.filter((data,i) -> return (data.get('score') > 0))
      #.filter((data,i) => return (i < @get('limit')))
    return res
  ).property('content.isLoaded','query','currentLetter')


App.FilteredMoviesController = Em.ArrayController.extend
  sortProperties: ['score','title']
  contentBinding: 'controllers.moviesListController.filteredMovies'
  currentMovieBinding: 'controllers.moviesController.movie'

  # overriding orderBy to have sort with different orders
  orderBy: (item1, item2) ->
    console.log 'order'
    result = 0
    result = -1 * Ember.compare(item1.get('score'),item2.get('score'))
    if result is 0
      result = Ember.compare(item1.get('title'),item2.get('title'))

    return result


