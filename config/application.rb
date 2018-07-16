require_relative "boot"
require "kaminari"
require "rails/all"
require "net/http"
require "openssl"
require "resolv-replace"

Bundler.require(*Rails.groups)

module SampleApp

  class Application < Rails::Application
    config.load_defaults 5.2
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
