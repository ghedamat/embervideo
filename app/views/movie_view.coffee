App.MovieView = Em.View.extend
    templateName: 'templates/movie'
    classNameBindings: ['isInserted']

    didInsertElement: ->
      @set('isInserted',true)

    launchFlowPlayer: ( ->
      if @get('controller.movie')
        setTimeout ()->
          flowplayer("player", {src: "/flowplayer/flowplayer-3.2.8.swf"},{clip:{ scaling: "fit" }})
        , 1000
    ).observes('controller.movie.isLoaded')
