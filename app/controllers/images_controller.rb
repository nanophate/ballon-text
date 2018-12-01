# -*- coding: utf-8 -*-
class ImagesController < ApplicationController
  def index
    @images = images_build
    render :index
  end

  def new
    @image_url = params[:image_url]
    render :new
  end

  def create
    image_url = params[:images][:url]
    text = params[:images][:text]
    image = MiniMagick::Image.open(image_url)
    image.combine_options do |config|
      config.font "GenEiKoburiMin4-R.ttf"
      config.gravity "center"
      config.pointsize 65
      config.draw "text 0,0 #{text}"
    end
    image.write "public/#{current_time}.png"
  end

  def images_build
    [
      {url: 'https://i.gyazo.com/39c92774e5f8eec6a30d1dbe3315f5da.png'},
      {url: 'https://i.gyazo.com/39c92774e5f8eec6a30d1dbe3315f5da.png'},
      {url: 'https://i.gyazo.com/39c92774e5f8eec6a30d1dbe3315f5da.png'}
    ]
  end

  private
  def current_time
    Time.now.strftime('%Y%m%d%H%m%s')
  end
end
