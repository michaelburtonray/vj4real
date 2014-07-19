class PlayerController < ApplicationController

  def index

    @video_left = params[:video_left]

    @video_right = params[:video_right]

    @audio_crossfade = params[:audio_crossfade] || 50


    @video_crossfade = params[:video_crossfade] || 50

  end

end
