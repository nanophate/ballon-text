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
    image = MiniMagick::Image.open(images_params[:url])
    caption = images_params[:text].encode(Encoding::UTF_8)
    x = images_params[:center_pos_x]
    y = images_params[:center_pos_y]

    begin
      image.combine_options do |config|
       config.font "public/GenEiKoburiMin4-R.ttf"
       config.gravity "center"
       config.pointsize 65
       config.draw "text #{x},#{y} '#{caption}''"
      end

      Tempfile.open { |t|
         t.binmode
         t.write image.to_blob
         t.close

         ActiveRecord::Base.transaction do
           caption = Caption.create!(name: caption)
           caption.image.attach(io: File.open(t.path), filename: current_time, content_type: "image/jpg")
         end
      }
    rescue => e
     p e
    end

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

  def images_params
    params.require(:images).permit(:text, :url)
  end
end
