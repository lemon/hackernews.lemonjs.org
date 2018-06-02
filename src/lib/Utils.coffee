
module.exports = lemon.Component {
  package: 'site'
  name: 'Utils'

  methods: {
    host: (url = '') ->
      host = url.replace(/^https?:\/\//, '').replace(/\/.*$/, '')
      parts = host.split('.').slice(-3)
      parts.shift() if parts[0] is 'www'
      return parts.join('.')

    timeAgo: (time) ->
      between = Date.now() / 1000 - Number(time)
      if between < 3600
        return @pluralize(~~(between / 60), ' minute')
      if between < 86400
        return @pluralize(~~(between / 3600), ' hour')
      return @pluralize(~~(between / 86400), ' day')

    pluralize: (count, label) ->
      return count + label if count is 1
      return count + label + 's'
  }
}
