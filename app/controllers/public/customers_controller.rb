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
      if @customer.profile_image.attached?
        #tags = Vision.get_image_data(@customer.profile_image)
        tags = Vision.get_image_data(StringIO.new(@customer.profile_image.download))
        #binding.irb
        Tag.where(customer_id: current_customer.id).destroy_all # 一旦自分のタグをすべて削除
        tags.each do |tag|
          # タグを登録していく
          Tag.create(customer_id: current_customer.id, name: tag)
          # @customer.profile_image.tags.create(name: tag)
        end
      end
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
    params.require(:customer).permit(:name,:telephone_number,:email,:profile_image)
  end

  def ensure_correct_customer
    @customer = current_customer
    redirect_to customers_path unless @customer = current_customer
  end
end