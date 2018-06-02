
# stylesheets
require '../css/Comment.styl'

# component
module.exports = lemon.Component {
  package: 'site'
  name: 'Comment'
  class: 'comment'

  data: {
    error: null
    item_id: null
    item: null
    loading: true
  }

  lifecycle: {
    mounted: ->
      site.api.fetchItem @item_id, (err, item) =>
        @error = err
        @item = item
        @loading = false
        lemon.addClass @el, 'open'
        setTimeout ( => lemon.addClass @el, 'loaded' ), 10
  }

  methods: {
    onToggle: ->
      lemon.toggleClass @el, 'open'
  }

  template: (data) ->
    div _on: 'loading', _template: (loading, data) ->
      {error, item} = data
      if error
        div '.error', ->
          error
      else if item
        div '.by', ->
          a href: "/user/#{item.by}", -> item.by
          text " #{site.utils.timeAgo item.time} ago"
        div '.text', ->
          raw item.text
        if item.kids?.length > 0
          div '.toggle', $click: 'onToggle', ->
            span '.is-open', -> '[-]'
            span '.is-closed', -> '[+]' + " #{item.kids.length} collapsed"
          div '.comment-children', ->
            for id in item.kids
              site.Comment {item_id: id}

}
