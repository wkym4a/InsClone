require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InsClone
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    #タイムゾーン設定を「東京」に変更
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    #CSS、JavaScript、Helperのファイルをrails g コマンドで自動生成しないように設定する
    config.generators do |g|
      g.assets false
      g.helper false
    end

  end
end
