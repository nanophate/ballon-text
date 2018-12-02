# -*- coding: utf-8 -*-
class ImagesController < ApplicationController
  def index
    @images = images_build
    @caption = Caption.all.with_attached_image
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
      config.font "public/GenEiKoburiMin4-R.ttf"
      config.gravity "center"
      config.pointsize 65
      config.draw "text 0,0 #{text}"
    end

    caption = Caption.create!(name: text)
    caption.image.attach(io: File.open(image.path), filename: current_time, content_type: "image/jpg")

    redirect_to images_path
  end

  def images_build
    [
      {url: 'https://i.gyazo.com/39c92774e5f8eec6a30d1dbe3315f5da.png'},
      {url: 'https://i.gyazo.com/dfe0386b3eece22f212c0a709ffbac5c.jpg'},
      {url: 'https://i.gyazo.com/758b0325446a548362cf4014374164d8.jpg'}
    ]
  end

  private
  def current_time
    Time.now.strftime('%Y%m%d%H%m%s')
  end
end
