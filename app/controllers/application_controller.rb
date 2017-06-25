class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
  helper_method :position, :groups_users_id, :getStatus, :identity, :get_user_identity

  def position group_id, user_id
  	return GroupsUser.find_by(group_id: group_id, user_id: user_id).position
  end

  def groups_users_id group_id, user_id
  	return GroupsUser.find_by(group_id: group_id, user_id: user_id).id
  end

  def getStatus group_id, user1_id, user2_id
  #   transaction1 = Transaction.find_by(group_id: group_id, debitor_id: user1_id, creditor_id: user2_id)
  #   transaction2 = Transaction.find_by(group_id: group_id, debitor_id: user2_id, creditor_id: user1_id)
  #   status = {}
  #   status['debit_amount'] = 0
  #   status['credit_amount'] = 0
  #   if(transaction1)
  #     status['debit_amount'] = transaction1.amount
  #   elsif transaction2
  #     status['credit_amount'] = transaction2.amount
  #   end
  #   return status  
  end

  def identity user_id
    user = User.find(user_id)
    if user == current_user
      return 'You'
    elsif user.person
      return user.person.name
    else
      return user.email
    end
  end

  def get_user_identity user_id
    user = User.find(user_id)
    if user.person
      return user.person.name
    else
      return user.email
    end
  end
end
