
# dependencies
require '../components/NewsItem'

# stylesheets
require '../css/NewsView.styl'

# component
module.exports = lemon.Component {
  package: 'site'
  name: 'NewsView'
  class: 'view'

  data: {
    error: null
    ids: []
    loading: true
    num_pages: 1
    page: 1
    page_size: 20
    type: null
  }

  methods: {

    onRoute: ({params}) ->
      page = parseInt(params.page) or 1
      type = params.type or 'new'
      start = @page_size * (page-1)
      end = @page_size * page
      @loading = true
      site.api.fetchStories type, (err, ids) =>
        @error = err
        @ids = ids[start...end]
        @page = page
        @type = type
        @num_pages = Math.ceil ids.length / @page_size
        @loading = false
        setTimeout ( => lemon.addClass @el, 'loaded' ), 10
  }

  routes: {
    '/(top|new|show|ask|jobs):type/*page': 'onRoute'
  }

  template: ->
    div '.view-nav', ->
      span _on: 'loading', _template: (loading, data) ->
        a {
          class: {disabled: data.page is 1}
          href: "/#{data.type}/#{data.page - 1}"
        }, ->
          '< prev'
        span ->
          text "#{data.page}/"
          text "#{data.num_pages}"
        a {
          class: {disabled: data.page is data.num_pages}
          href: "/#{data.type}/#{data.page + 1}"
        }, ->
          'more >'

    div '.news-list', _on: 'loading', _template: (loading, data) ->
      {error, ids} = data
      if error
        div '.error', ->
          error
      else if not loading and ids
        for id in ids
          site.NewsItem {item_id: id}
  }
