source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem "pg", "~> 1.1"
gem 'puma', '~> 5.0'

gem 'date'

gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'

gem 'bootsnap', '>= 1.4.4', require: false

# custom gems begin
gem "tailwindcss-rails", "~> 2.0"
gem "devise", "~> 4.9"
gem 'i18n'
gem 'rails-i18n'
gem 'mailcatcher'
gem 'pundit'
# end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'hirb'
end
