require_relative "boot"

require "rails/all"
require 'rack'
require 'rack/cors'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete, :options], expose: ['Authorization']
      end
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.action_mailer.default_url_options = { :host => 'http://localhost:5173/' }

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = false
    config.action_mailer.default :charset => "utf-8"


    config.action_mailer.smtp_settings = {
      :user_name => '2f271fc6939007',
      :password => 'f69066e74950be',
      :address => 'sandbox.smtp.mailtrap.io',
      :host => 'sandbox.smtp.mailtrap.io',
      :port => '2525',
      :authentication => :login
    }
  end
end
