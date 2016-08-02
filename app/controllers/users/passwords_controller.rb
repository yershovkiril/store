class Users::PasswordsController < Devise::PasswordsController
  skip_before_filter :require_no_authentication, :only => [ :update ]
  
  def update
    if current_user.update_with_password(user_params)
      bypass_sign_in(current_user)
      flash[:notice] = t('user.flashes.password_updated')
      redirect_to edit_user_path
    else
      render 'users/edit'
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
