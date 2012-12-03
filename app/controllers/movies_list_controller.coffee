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
    return Ember.A(res)
  ).property('content.isLoaded','query','currentLetter')


App.FilteredMoviesController = Em.ArrayController.extend
  init: ->
    console.log('init')
    console.log @get('arrangedContent')
  sortProperties: ['score']
  contentBinding: 'controllers.moviesListController.filteredMovies'
  currentMovieBinding: 'controllers.moviesController.movie'

  # overriding orderBy to have sort with different orders
  orderBy: (item1, item2) ->
    result = 0
    result = -1 * Ember.compare(item1.get('score'),item2.get('score'))
    if result is 0
      result = Ember.compare(item1.get('title'),item2.get('title'))

    return result

  arrangedContent: Ember.computed('content', 'sortProperties.@each', (key, value) ->
    content = @get('content')
    isSorted = @get('isSorted')
    sortProperties = @get('sortProperties')
    self = @

    if (content && isSorted)
      content = content.slice()
      content.sort((item1, item2) ->
        return self.orderBy(item1, item2);
      )
      content.forEach( (item) ->
        sortProperties.forEach((sortProperty) ->
          Ember.addObserver(item, sortProperty, this, 'contentItemSortPropertyDidChange');
        , @)
      , @);
      return Ember.A(content);

    return content;
  ).property().volatile(),


