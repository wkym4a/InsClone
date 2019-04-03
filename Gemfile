source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

#環境ファイル「.env」を管理するために追加
gem 'dotenv-rails'

#テストデータ作成用
gem 'faker'

#has_secure_passwordメソッドを使用するため、追加
gem 'bcrypt', '3.1.11'

#画像間利用
gem 'carrierwave'
gem 'mini_magick'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'

  # 開発、検証用に追加
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-byebug'

  #テスト用に追加（テキスト：Rspec1【テスト駆動開発とRspecの初期設定について】）
  gem 'spring'
  gem "rspec-rails"
  gem 'spring-commands-rspec'
  gem "factory_bot_rails"
  gem 'faker'
  gem "database_cleaner"
  gem "launchy"
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  #gem 'spring' →　「:development, :test」に移動
  gem 'spring-watcher-listen', '~> 2.0.0'

  #開発環境でのメール受信検証用に追加
  gem 'letter_opener_web'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
