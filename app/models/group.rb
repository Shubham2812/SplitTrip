class Group < ActiveRecord::Base

	has_many :groups_users
	has_many :transactions

	def members
		groups_users = GroupsUser.where(group_id: self.id)
		members = []
		groups_users.each do |group_user|
			person = Person.find_by(user_id: group_user.user_id)
			if person
				members << person
			else	
				user = User.find(group_user.user_id)
				members << user
			end
		end
		return members
	end
end
