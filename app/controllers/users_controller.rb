class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = t('user.flashes.account_updated')
      redirect_to edit_user_path
    else
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :current_password,
      billing_address_attributes: address_attributes,
      shipping_address_attributes: address_attributes
    )
  end
  
  def address_attributes
    %i(id first_name last_name address zip city phone country_id)
  end
end
