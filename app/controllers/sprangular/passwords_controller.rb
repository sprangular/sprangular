class Sprangular::PasswordsController < Sprangular::BaseController
  append_view_path "lib/views/frontend"

  def create
    if user = Spree::User.find_by(email: params[:spree_user][:email])
      Spree::User.send_reset_password_instructions(user)
    else
      user.errors[:email] = 'Email address not found'
    end

    respond_with user
  end

  def update
    if params[:spree_user][:password].blank?
      user = Spree::User.new
      user.errors[:password] = "Cannot be blank"
    else
      user = Spree::User.reset_password_by_token(params[:spree_user])
      if user.errors.empty?
        sign_in :spree_user, user
      end
    end

    respond_with user
  end
end
