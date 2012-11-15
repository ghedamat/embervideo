App.MoviesListView = Em.View.extend
  templateName: 'templates/movies_list'
  search: Em.TextField.extend
    keyUp: ((e) ->
      @set('controller.query',@get('value'))
    ).debounce(400)
  listView: Em.CollectionView.extend
    contentBinding: 'controller'
    itemViewClass: Ember.View.extend
      classNames: ['movie_item', 'alert']
      classNameBindings: ['isSelected:alert-error:alert-info']
      templateName: 'templates/movie_item'
      click: (e) ->
        App.router.send('goToMovie',@get('content.id'))
        false
      isSelected: (->
        @get('content') == @get('controller.currentMovie')
      ).property('controller.currentMovie')
