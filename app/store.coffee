App = require('app')
App.Store = DS.Store.extend
  revision: 7,
  adapter: DS.RESTAdapter.create()
