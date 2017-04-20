class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :position, :groups_users_id

  def position group_id, user_id
  	return GroupsUser.find_by(group_id: group_id, user_id: user_id).position
  end

  def groups_users_id group_id, user_id
  	return GroupsUser.find_by(group_id: group_id, user_id: user_id).id
  end
end
