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
end
