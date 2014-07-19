# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Player
  constructor: (player_el)->

    # 2. This code loads the IFrame Player API code asynchronously.
    tag = document.createElement('script')
    tag.src = "https://www.youtube.com/iframe_api"
    firstScriptTag = document.querySelectorAll('script')[0]
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)


    window.player_left_el = document.querySelector('#player-left')
    window.player_right_el = document.querySelector('#player-right')

    document.querySelector('#crossfade_audio').addEventListener 'input', fadeAudio
    document.querySelector('#crossfade_video').addEventListener 'input', fadeVideo



  window.onYouTubeIframeAPIReady = ->

    window.player_left = new YT.Player('player-left', {
      height: '195',
      width: '260',
      videoId: 'Ud6sU3AclT4',
      events: {
        'onReady': onPlayerReady,
        'onStateChange': onPlayerStateChange
      }
    })


    window.player_right = new YT.Player('player-right', {
      height: '195',
      width: '260',
      videoId: 'R8AOAap6_k4',
      events: {
        'onReady': onPlayerReady,
        'onStateChange': onPlayerStateChange
      }
    })


  onPlayerReady = (event)->
    event.target.setVolume(0)
    event.target.playVideo()


  done = false
  onPlayerStateChange = (event)->
    if (event.data == YT.PlayerState.PLAYING && !done)
      done = true
    event.target.setVolume(0)



  fadeVideo = (event)->
    console.log(event.target.value)

    document.querySelector('#player-left').style.opacity = event.target.value / 100
    document.querySelector('#player-right').style.opacity = (100 - event.target.value) / 100

  fadeAudio = (event)->
    console.log(event.target.value)

    window.player_left.setVolume(event.target.value)
    window.player_right.setVolume((100 - event.target.value))





document.addEventListener('DOMContentLoaded', ->
  player_el = document.querySelector('.player')
  player = new Player(player_el)
)