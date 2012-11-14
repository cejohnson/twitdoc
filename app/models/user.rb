class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :omniauthable

  field :oauth_provider,      :type => String
  field :oauth_uid,           :type => String

  field :twitter_nickname, :type =>String
  
  def self.find_for_twitter_oauth(omniauth)
    puts omniauth.inspect
    
    user = User.where(:oauth_provider => omniauth['provider'], :oauth_uid => omniauth['uid']).first
    
    unless user
      user = User.create!(:oauth_provder => omniauth['provider'], 
                          :oauth_uid => omniauth['uid'],
                          :twitter_nickname => omniauth['info']['nickname'])
      # you may want to pull more information out of the omniauth hash for this user
    end
    
    user
  end
end
