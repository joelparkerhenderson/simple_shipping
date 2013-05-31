source 'https://rubygems.org'

gem 'activesupport' , '~> 3.1'
gem 'activemodel'   , '~> 3.1'
gem 'savon', '~> 2.1'

group :development do
  gem 'rspec'  , '~> 2.3.0'
  gem 'yard'   , '~> 0.6.0'
  gem 'bundler'
  gem 'jeweler', '~> 1.6.4'
  gem 'rcov'   , '>= 0'
  gem 'reek'   , '~> 1.2.8'
  gem 'roodi'  , '~> 2.1.0'
  gem 'gemfury', :require => false
  gem 'json_pure'
  gem 'forgery'
  gem 'rmagick'

  unless ENV['RM_INFO']
    gem 'ruby-debug'
  end
end

group :test do
  gem 'webmock'
  gem 'timecop'
  gem 'erubis'
  gem 'equivalent-xml'
end
