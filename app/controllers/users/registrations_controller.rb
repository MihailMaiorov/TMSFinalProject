# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: %i[create update]

    def create
      super do |user|
        if user.persisted?
          Users::Greetings::SendMailWorker.perform_async(user.id)
          user.add_role(params[:role]) if params[:role].present?
        end
      end
    end

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
    end
  end
end
