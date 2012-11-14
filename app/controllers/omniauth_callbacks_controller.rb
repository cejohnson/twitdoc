class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.find_for_twitter_oauth(env['omniauth.auth'])
    
    flash[:notice] = 'successfully signed in'
    sign_in_and_redirect @user
  end
end