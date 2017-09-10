class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    connect_to_stripe_path
  end
end
