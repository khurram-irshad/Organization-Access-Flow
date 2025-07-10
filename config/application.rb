require_relative "boot"
   require "rails/all"
   Bundler.require(*Rails.groups)

   module OrganizationAccessFlow
     class Application < Rails::Application
       config.load_defaults 8.0
       config.autoload_lib(ignore: %w[assets tasks])
       config.assets.paths << Rails.root.join("app", "assets", "builds")
       config.assets.precompile = %w[application.css active_admin.css application.js]
     end
   end