class VendorOnboardingController < ApplicationController
  before_action :authenticate_vendor!

  def connect_to_stripe
  end

  def stripe_connect_confirmation
  end
end
