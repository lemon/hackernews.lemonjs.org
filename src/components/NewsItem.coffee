
module.exports = lemon.Component {
  package: 'site'
  name: 'NewsItem'
  class: 'news-item'

  data: {
    item_id: null
    loading: true
    error: null
    item: null
  }

  lifecycle: {
    mounted: ->
      site.api.fetchItem @item_id, (err, item) =>
        @error = err
        @item = item
        @loading = false
        setTimeout ( => lemon.addClass @el, 'loaded' ), 10
  }

  template: (data) ->
    div _on: 'loading', _template: (loading, data) ->
      {error, item} = data
      if error
        div '.error', ->
          error
      else if item
        if item.score
          span '.score', -> "#{item.score}"
        span '.title', ->
          a href: item.url, target: '_blank', rel: "noopener", ->
            item.title
          if item.url
            span '.host', ->
              site.utils.host item.url
        br()
        span '.meta', ->
          span '.by', ->
            text 'by '
            a href: "/user/#{item.by}", -> item.by
          span '.time', ->
            site.utils.timeAgo item.time
          span '.comments-link', ->
            text ' | '
            a href: "/item/#{item.id}", ->
              "#{(item.kids or []).length} comments"

}
