
# dependencies
require '../css/Header.styl'

# component
module.exports = lemon.Component {
  package: 'site'
  name: 'Header'
  id: 'header'

  methods: {
    onRoute: ({params}) ->
      links = @find 'a'
      for link in links
        lemon.removeClass link, 'active'
      match = @findOne "a[href='/#{params.type}']"
      lemon.addClass match, 'active'
  }

  routes: {
    '/:type/*': 'onRoute'
  }

  template: (data) ->
    nav '.inner', ->
      a href: '/', 'aria-label', 'Home Page', ->
        img '.logo', src: '/img/icon-128.png', alt: 'logo'
      a href: '/top', 'aria-label': 'Top News', -> 'Top'
      a href: '/new', 'aria-label': 'New News', -> 'New'
      a href: '/show', 'aria-label': 'Show HN', -> 'Show'
      a href: '/ask', 'aria-label': 'Ask HN', -> 'Ask'
      a href: '/jobs', 'aria-label': 'Jobs', -> 'Jobs'
      a '.github', {
        'href': 'https://github.com/lemon/hackernews.lemonjs.org'
        'aria-label': 'Source Code on Github'
      }, ->
        'Built with Lemon.js'
}
