class Sprangular::PasswordsController < Sprangular::BaseController

  def create
    user = Spree::User.find_or_initialize_by(email: params[:spree_user][:email])

    if user.persisted?
      raw, enc = Devise.token_generator.generate(Spree::User, :reset_password_token)

      user.reset_password_token   = enc
      user.reset_password_sent_at = Time.now.utc
      user.save(validate: false)

      reset_url = main_app.root_url+"#!/reset-password/#{raw}" # main_app.store_password_url(id: raw)
      UserMailer.reset_password_instructions(user, reset_url).deliver
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
