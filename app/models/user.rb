class User < ActiveRecord::Base
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"] || "Generic Person - GET A NAME ;)"
    end
  end

  def self.find_by_provider_and_uid(provider, uid)
    where(provider: provider, uid: uid).first
  end
end
