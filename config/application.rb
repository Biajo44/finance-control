require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FinanceControl
  class Application < Rails::Application
    config.load_defaults 8.1

    config.i18n.default_locale = :"pt-BR"
    config.i18n.available_locales = [ :"pt-BR", :en ]

    config.autoload_lib(ignore: %w[assets tasks])
  end
end
