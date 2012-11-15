App.MoviesListController = Em.ArrayController.extend
  sortProperties: ['score','title']
  sortAscending: false
  setScores: (()->
    if @get('query') == undefined
      return @get('content')
    else
      co=  @get('content').forEach (data,i) =>
        score = $.fuzzyMatch(data.get('title'), @get('query')).score
        data.set('score',score)
        console.log data.get('score')
        return data
      console.log co
      return co
  ).observes('content','query')


