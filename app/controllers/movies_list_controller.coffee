App.MoviesListController = Em.ArrayController.extend
  sortProperties: ['score','title']
  sortAscending: false
  limit: 10
  maxLimitBinding: 'length'
  currentLetter: 'ALL'

  currentMovieBinding: 'controllers.moviesController.movie'

  hasMovie: (->
    if @get('currentMovie')
      return "span3"
    else
      return "span11"
  ).property('currentMovie')

  filteredMovies: ( ->
    res = @
    if @get('currentLetter') == 'ALL'
    else
      res = res.filter (data,i) =>
        (@get('currentLetter') == data.get('title')[0]) || (@get('currentLetter').toLowerCase() == data.get('title')[0])
    if @get('query') == undefined
      res = res.filter (data,i) -> return true
      #@filter (data,i) => return (i < @get('limit'))
    else
      @forEach (data,i) =>
        score = $.fuzzyMatch(data.get('title'), @get('query')).score
        data.set('score',score)
      res = res.filter((data,i) -> return (data.get('score') > 0))
      #.filter((data,i) => return (i < @get('limit')))
    return res
  ).property('content.isLoaded','query','limit','currentLetter')


