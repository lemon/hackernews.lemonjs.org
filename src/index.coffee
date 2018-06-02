
# dependencies
require './App'

# page template
module.exports = ->
  doctype 5
  html lang: 'en', ->
    head ->
      title -> 'HackerNews on lemon'
      meta name: 'Description', content: 'HackerNews on lemon.js'
      meta charset: "utf-8"
      meta name: "mobile-web-app-capable", content: "yes"
      meta name: "apple-mobile-web-app-capable", content: "yes"
      meta name: "apple-mobile-web-app-status-bar-style", content: "default"
      meta name: "theme-color", content: "#f60"
      meta name: "viewport", content:"width=device-width, initial-scale=1, minimal-ui"
      link rel: "apple-touch-icon", sizes:"144x144", href: "/img/logo-144.png"
      link rel: "shortcut icon", sizes: "64x64", href: "/img/icon-64.png"
      link rel: "manifest", href: "/manifest.json"
    body ->
      site.App()
