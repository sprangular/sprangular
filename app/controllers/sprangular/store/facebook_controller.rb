class Sprangular::Store::FacebookController < Sprangular::Store::BaseController

  def fetch
    access_token = params['accessToken']
    supplied_email = params['email']

    fb_user = FbGraph::User.me(access_token).fetch

    if fb_user
      # valid token
      user_authentication = Spree::UserAuthentication.find_or_create_by(uid: fb_user.identifier, provider: 'facebook')

      if user_authentication && user_authentication.user
        sign_in :spree_user, user_authentication.user
        render json: user_authentication.user
      else
        email = fb_user.email
        email ||= supplied_email
        if email.present?
          user_authentication = Spree::UserAuthentication.find_or_create_by(uid: fb_user.identifier, provider: 'facebook')
          if user_authentication.user.blank?
            user = Spree::User.find_by_email email
            if user.blank?
              password = SecureRandom.hex(16)
              user = Spree::User.create! email: email, password: password, password_confirmation: password
            end
            user_authentication.update_attribute(:user_id, user.id)
          end
          sign_in :spree_user, user_authentication.user
          render json: user_authentication.user
        else
          error = 'no email provided by facebook'
          render json: error.to_json, status: 404
        end
      end
    else
      error = 'no facebook user'
      render json: error.to_json, status: 403
    end

  rescue => ex
    render json: ex.message.to_json, status: 422
  end

end
