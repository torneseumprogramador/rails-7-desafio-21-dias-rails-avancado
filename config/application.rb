require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LayoutRails7
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.i18n.default_locale = :'pt-BR'

    # config.autoload_paths += %W(#{config.root}/app/entidades)
    # config.autoload_paths += %W(#{config.root}/app/repositorios)

    config.after_initialize do
      Devise::SessionsController.class_eval do
          def create
              debugger
              self.resource = warden.authenticate!(auth_options)
              set_flash_message!(:notice, :signed_in)
              sign_in(resource_name, resource)
              yield resource if block_given?
              respond_with resource, location: after_sign_in_path_for(resource)
          end
      end
    end

  end
end
