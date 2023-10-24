# frozen_string_literal: true

require 'devise/omniauth'
# Work around for bug when scoping paths
# See: https://github.com/spree/spree_social/issues/130
OmniAuth.config.on_failure = proc do |env|
  env['devise.mapping'] = Devise.mappings[:user]
  controller_name  = ActiveSupport::Inflector.camelize(env['devise.mapping'].controllers[:omniauth_callbacks])
  controller_klass = ActiveSupport::Inflector.constantize("#{controller_name}Controller")
  controller_klass.action(:failure).call(env)
end
