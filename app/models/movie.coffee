App = require('app')
App.Movie =  DS.Model.extend
  title: DS.attr('string')
  path: DS.attr('string')
  playPath: ( ->
    "/flv/" + @get('path')
  ).property('path')

