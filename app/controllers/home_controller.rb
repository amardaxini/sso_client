class HomeController < ApplicationController
  def index
  end

  def tickets
  	# sso_redirect = "http://purple.lvh.me:3004/sso?&email="+current_user.email+"&timestamp="+utctime+"&hash="+gen_hash_from_params_hash(utctime)
  	sso_redirect = "http://abc.lvh.me:3004/sso?&data=#{gen_hash_from_params_hash}"
  	redirect_to sso_redirect
  end

 	def gen_hash_from_params_hash
    hash_key ="b23b7575e1a591cda109f3d1bb4c1212cb492aabc328e82e28bc78ff2fcb7ac0"
 		email_text = "email=#{current_user.email}"
 		Aes::encrypt("#{email_text}||time=#{time_in_utc}", hash_key)
  	
	end
	def time_in_utc
    Time.now.getutc.to_i.to_s
  end
end
