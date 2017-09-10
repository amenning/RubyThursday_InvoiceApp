class VendorOnboardingController < ApplicationController
  before_action :authenticate_vendor!

  def connect_to_stripe
  end
end
