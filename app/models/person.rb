class Person < ActiveRecord::Base
	belongs_to :user

	def email
		user.email
	end

	def avatar
		if(photo)
			return '/uploads/users/' + id.to_s + '_' + photo
		else
			return '/images/male.png'
		end
	end
end
