
# stylesheets
require '../css/UserView.styl'

# component
module.exports = lemon.Component {
  package: 'site'
  name: 'UserView'
  class: 'view'

  data: {
    loading: true
    error: null
    user: null
  }

  lifecycle: {
    mounted: ->
      site.api.fetchUser @params.id, (err, user) =>
        @error = err
        @user = user
        @loading = false
        setTimeout ( => lemon.addClass @el, 'loaded' ), 10
  }

  template: (data) ->
    div '.user-view', ->
      div _on: 'loading', _template: (loading, data) ->
        {error, user} = data
        if error
          div '.error', ->
            error
        else if user
          h1 -> "User: #{user.id}"
          ul '.meta', ->
            li ->
              span '.label', -> 'Created:'
              span '.value', -> site.utils.timeAgo user.created
            li ->
              span '.label', -> 'Karma:'
              span '.value', -> "#{user.karma}"
          div '.about', ->
            raw user.about
          div '.links', ->
            a href: "https://news.ycombinator.com/submitted?id=#{user.id}", ->
              'submissions'
            text " | "
            a hreF: "https://news.ycombinator.com/threads?id=#{user.id}", ->
              'comments'
}
