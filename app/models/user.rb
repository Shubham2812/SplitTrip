class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_one :person
  has_many :contacts
  has_many :groups_users
  has_many :messages

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  	def contact
		return Contact.find_by(user_id: self.id)
	end

	def groups
		groups_users = GroupsUser.where(user_id: self.id)
		groups = []
		groups_users.each do |group_user|
			groups << Group.find(group_user.group_id)
		end
		return groups
	end

	def avatar
		if person
		person.avatar
		else
			'/images/male.png'
		end
	end
end
