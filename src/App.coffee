
# dependencies
require './components/Header'
require './lib/Api'
require './lib/Utils'
require './views/ItemView'
require './views/NewsView'
require './views/PageNotFoundView'
require './views/UserView'

# stylesheets
require './css/App.styl'

# component
module.exports = lemon.Component {
  package: 'site'
  name: 'App'
  id: 'app'

  lifecycle: {
    created: ->
      site.api = new site.Api()
      site.utils = new site.Utils()
  }

  template: (data) ->
    site.Header()
    main ->
      lemon.Router {
        beforeRoute: (current, prev) ->
          return current.action isnt prev.action
        routes: {
          '/': -> lemon.route '/top'
          '/(top|new|show|ask|jobs):type/*page': site.NewsView
          '/user/:id': site.UserView
          '/item/:id': site.ItemView
          '/*': site.PageNotFoundView
        }
        routed: ->
          lemon.scrollTo document.body
      }
}
