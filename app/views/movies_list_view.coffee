App.MoviesListView = Em.View.extend
  templateName: 'templates/movies_list'
  search: Em.TextField.extend
    keyUp: ((e) ->
      @set('controller.query',@get('value'))
    ).debounce(400)
  didInsertElement: ->
    $('footer').bind 'inview', (event, isInView, visiblePartX, visiblePartY) =>
      if isInView
        if @get('controller.limit') < @get('controller.maxLimit')
          @set('controller.limit', @get('controller.limit')+10)
    $('header').bind 'inview', (event, isInView, visiblePartX, visiblePartY) =>
      if isInView
        @set('controller.limit', 10)


  listView: Em.CollectionView.extend
    contentBinding: 'controller.filteredMovies'
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
