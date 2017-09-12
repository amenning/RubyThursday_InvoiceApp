class SubscriptionsController < ApplicationController
  def new
    @invoice = Invoice.find(params[:invoice_id])
    @subscription = @invoice.subscriptions.build
  end

  def create
    @invoice = Invoice.find(params[:invoice_id])

    if params[:stripeToken]
      @subscription = @invoice.subscriptions.build(subscription_params)
      @token = params[:stripeToken]
      vendor = @invoice.vendor
      @stripe_account = vendor.stripe_uid
      @create_customer_response = create_customer(@subscription.customer_email, @token, @stripe_account)
      @create_subscription_response = create_subscription(@create_customer_response.id, @invoice.id_for_plan, @stripe_account)

      @subscription.id_for_customer = @create_customer_response.id
      @subscription.id_for_subscription = @create_subscription_response.id
      respond_to do |format|
        if @subscription.save
          format.html { redirect_to confirmation_invoice_subscription_path(@invoice, @subscription) }
        else
          format.html { render :new }
          format.json { redner json: @subscription.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def confirmation
  end

  private
    def subscription_params
      params.require(:subscription).permit(:invoice_id, :customer_email)
    end

    def create_customer(email, token, stripe_account)
      Stripe::Customer.create(
        {
          description: 'Gigtilt customer ' + email,
          source: token
        },
        {stripe_account: stripe_account}
      )
    end

    def create_subscription(customer, plan, stripe_account)
      Stripe::Subscription.create(
        {
          customer: customer,
          items: [{plan: plan}]
        },
        {stripe_account: stripe_account}
      )
    end
end
