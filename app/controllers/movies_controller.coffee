App.MoviesController = Em.ObjectController.extend
  content: {}
  hasMovie: (->
    if @get('movie')
      return "span4"
    else
      return "span12"
  ).property('movie')
