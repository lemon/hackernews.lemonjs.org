
# stylesheets
require '../css/ItemView.styl'

# dependencies
require '../components/Comment'

# component
module.exports = lemon.Component {
  package: 'site'
  name: 'ItemView'
  class: 'view'

  data: {
    loading: true
    error: null
    item: null
  }

  lifecycle: {
    mounted: ->
      site.api.fetchItem @params.id, (err, item) =>
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

        div '.item-view-header', ->
          a href: item.url, target: '_blank', rel: "noopener", ->
            h1 ->
              item.title
          if item.url
            span '.host', ->
              "(#{site.utils.host item.url})"
          p '.meta', ->
            text "#{item.score} points | by "
            a href: "/user/#{item.by}", ->
              item.by
            text " #{site.utils.timeAgo item.time} ago"

        div '.item-view-comments', ->
          div '.item-view-comments-header', ->
            "#{item.descendants} comments"
          ul '.comment-children', ->
            for id in item.kids or []
              site.Comment {item_id: id}

}
