# encoding: utf-8

require 'sinatra'
require 'haml'
require 'pry'
require 'mini_magick'

def current_time
  Time.now.strftime('%Y%m%d%H%m%s')
end

get '/' do
  haml :index
end

post '/image' do

  text = params['name']
  image = MiniMagick::Image.open(File.join('public', 'original.png'))
  image.combine_options do |config|
    config.font "GenEiKoburiMin4-R.ttf"
    config.gravity "center"
    config.pointsize 65
    config.draw "text 0,0 #{text}"
  end
  image.write "public/#{current_time}.png"

  @image_path = "#{current_time}.png"

  haml :image
end
