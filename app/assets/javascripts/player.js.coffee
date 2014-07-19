# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Player
  constructor: (player_el)->

    window.queue = 2

    @player_el = player_el

    window.form_el = @player_el.querySelector('form')

    # 2. This code loads the IFrame Player API code asynchronously.
    tag = document.createElement('script')
    tag.src = "https://www.youtube.com/iframe_api"
    firstScriptTag = document.querySelectorAll('script')[0]
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)


    window.player_left_el = document.querySelector('#player-left')
    window.player_right_el = document.querySelector('#player-right')

    crossfade_audio_el = document.querySelector('#crossfade_audio')

    crossfade_audio_el.addEventListener 'input', fadeAudio

    event = new Event('input')
    # crossfade_audio_el.dispatchEvent(event);


    crossfade_video_el = document.querySelector('#crossfade_video')

    crossfade_video_el.addEventListener 'input', fadeVideo


    crossfade_video_el.dispatchEvent(event);




  window.onYouTubeIframeAPIReady = ->

    videoId = window.form_el.video_left.value.split('v=')[1] || undefined

    if(videoId)
      window.player_left = new YT.Player('player-left', {
        height: '195',
        width: '260',
        loop: 1,
        playlist: videoId,
        videoId: videoId,
        events: {
          'onReady': onPlayerReady,
          'onStateChange': onPlayerStateChange
        }
      })

    videoId = window.form_el.video_right.value.split('v=')[1] || undefined

    if(videoId)
      window.player_right = new YT.Player('player-right', {
        height: '195',
        width: '260',
        loop: 1,
        playlist: videoId,
        videoId: videoId,
        events: {
          'onReady': onPlayerReady,
          'onStateChange': onPlayerStateChange
        }
      })


  onPlayerReady = (event)->
    # event.target.setVolume(0)
    event.target.playVideo()

    window.queue--
    if(window.queue == 0)
      event = new Event('input')
      document.querySelector('#crossfade_audio').dispatchEvent(event)



  done = false
  onPlayerStateChange = (event)->
    if (event.data == YT.PlayerState.PLAYING && !done)
      done = true
    # event.target.setVolume(0)



  fadeVideo = (event)->
    console.log(event.target.value)

    document.querySelector('#player-left').style.opacity = event.target.value / 100
    document.querySelector('#player-right').style.opacity = (100 - event.target.value) / 100

  fadeAudio = (event)->
    console.log(event.target.value)

    window.player_left.setVolume(event.target.value)
    window.player_right.setVolume((100 - event.target.value))





document.addEventListener('DOMContentLoaded', ->
  player_el = document.querySelector('#player')
  player = new Player(player_el)
)