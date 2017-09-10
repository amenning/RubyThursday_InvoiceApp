class InvoicesController < ApplicationController
  before_action :authenticate_vendor!

  def index
    @invoices = current_vendor.invoices
  end

  def new
    @invoice = current_vendor.invoices.build
  end

  def create
    @invoice = current_vendor.invoices.create(invoice_params)
    response = create_stripe_plan(current_vendor, @invoice)
    @invoice.id_for_plan = response.id

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoices_path, notice: 'Invoice successfully created!' }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def invoice_params
      params.require(:invoice).permit(:name, :description, :amount)
    end

    def create_stripe_plan(vendor, invoice)
      Stripe::Plan.create(
        {
          amount: invoice.amount,
          interval: 'month',
          name: invoice.name,
          currency: 'usd',
          id: invoice.name
        },
        stripe_account: vendor.stripe_uid
      )
    end
end
