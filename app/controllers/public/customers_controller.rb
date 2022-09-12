class Public::CustomersController < ApplicationController
  before_action :ensure_correct_customer, only: [:show, :edit, :unsubscribe, :update, :withdraw]

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
    redirect_to customer_path(current_customer)
    end
  end

  def unsubscribe
     @customer = Customer.find_by(email: params[:email])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customers_params)
      redirect_to customer_path(current_customer)
    end
  end

  def withdraw
    @customer = Customer.find_by(email: params[:email])
    current_customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def customers_params
    params.require(:customer).permit(:name,:telephone_number,:email)
  end

  def ensure_correct_customer
    @customer = current_customer
    redirect_to products_path unless @customer = current_customer
  end

end