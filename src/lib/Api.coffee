
module.exports = lemon.Component {
  package: 'site'
  name: 'Api'

  data: {
    cache: {}
    root: 'https://hacker-news.firebaseio.com/v0'
  }

  methods: {

    fetch: (key, next) ->
      return setTimeout(( => next null, @cache[key]), 1) if @cache[key]
      lemon.ajax {
        method: 'GET'
        url: "#{@root}/#{key}.json"
      }, (err, data) =>
        @cache[key] = data
        next err, data

    fetchItem: (id, next) ->
      @fetch "item/#{id}", next

    fetchStories: (type, next) ->
      type = 'job' if type is 'jobs'
      @fetch "#{type}stories", next

    fetchUser: (id, next) ->
      @fetch "/user/#{id}", next

  }
}
