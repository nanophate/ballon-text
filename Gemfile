source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.2.rc1'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jbuilder'
gem 'haml'
gem "mini_magick"

gem 'bootsnap', '>= 1.1.0', require: false
gem "aws-sdk-s3", require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'sqlite3'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
end

group :production , :staging do
  gem 'pg'
end
