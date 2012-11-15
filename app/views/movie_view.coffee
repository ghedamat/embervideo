App.MovieView = Em.View.extend
    templateName: 'templates/movie'
    launchFlowPlayer: ( ->
      setTimeout ()->
        flowplayer("player", {src: "/flowplayer/flowplayer-3.2.8.swf"},{clip:{ scaling: "fit" }})
      , 1000
    ).observes('controller.movie.isLoaded')
