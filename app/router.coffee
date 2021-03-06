Ember.LOG_BINDINGS = true
App = require('app')

App.Router = Em.Router.extend
  location: 'history'
  enableLogging: true

  root: Em.Route.extend
    goToMovies: Em.Router.transitionTo('root.movies.index')
    goToMovie: Em.Router.transitionTo('root.movies.movie')
    index: Em.Route.extend
      route: '/em'
      redirectsTo: 'root.movies.index'

    movies: Em.Route.extend
      route: '/em/movies'
      connectOutlets: (router, context) ->
        movies = App.Movie.find({})
        router.get('applicationController').connectOutlet('movies')
        router.get('moviesController').connectOutlet('lista', 'moviesList',movies)
        router.get('moviesListController').connectOutlet('alphabet', 'movieAlphabet')
        router.get('moviesListController').connectOutlet('filtered', 'filteredMovies')
        # router.get('moviesController').connectOutlet
        #   outletName: 'lista'
        #   name: "moviesList"

      index: Em.Route.extend
        route: '/'
        connectOutlets: (router, context) ->
          router.get('moviesController').connectOutlet('movie')
          router.set('moviesController.movie',null)

      movie: Em.Route.extend
        route: '/:id'
        deserialize: (router,params)->
          return params.id
        serialize: (router,context) ->
          return {id: context}

        connectOutlets: (router, id) ->
          movie = App.Movie.find(id)
          router.set('moviesController.movie',movie)
          router.get('moviesController').connectOutlet('movie')
