class SubscriptionsController < ApplicationController
  def new
    @invoice = Invoice.find(params[:invoice_id])
    @subscription = @invoice.subscriptions.build
  end

  def create
    @invoice = Invoice.find(params[:invoice_id])

    if params[:stripeToken]
      @token = params[:stripeToken]
    end

    @subscription = @invoice.subscriptions.build(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to confirmation_invoice_subscription_path(@invoice, @subscription) }
      else
        format.html { render :new }
        format.json { redner json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirmation
  end

  private
    def subscription_params
      params.require(:subscription).permit(:invoice_id, :customer_email)
    end
end
