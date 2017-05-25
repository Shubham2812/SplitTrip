class TransactionController < ApplicationController

	def evaluate
		params.each do |key, value|
			key = key.split("_")
			value = value.to_i
			if(value != 0)
				if(key[0] == 'debit')
				  	transaction1 = Transaction.find_by(group_id: params[:group_id], debitor_id: current_user.id, creditor_id: key[1])
				  	transaction2 = Transaction.find_by(group_id: params[:group_id], debitor_id: key[1], creditor_id: current_user.id)
				  	if transaction1
				  		transaction1.amount += value
				  		transaction1.save
				  	elsif transaction2
				  		if transaction2.amount > value
				  			transaction2.amount -= value
				  		elsif transaction2.amount < value
				  			temp = transaction2.debitor_id
				  			transaction2.debitor_id = transaction2.creditor_id
				  			transaction2.creditor_id = temp
				  			transaction2.amount = value - transaction2.amount
				  		else
				  			transaction2.destroy
				  		end
				  		transaction2.save
				  	else
				  		Transaction.create(
				  				group_id: params[:group_id],
				  				debitor_id: current_user.id,
				  				creditor_id: key[1],
				  				amount: value,
				  				status: 'pending',
				  				confirmed_by: 'none' 
				  			)
				  	end
				elsif(key[0] == 'credit')
				  	transaction1 = Transaction.find_by(group_id: params[:group_id], debitor_id: key[1], creditor_id: current_user.id)
				  	transaction2 = Transaction.find_by(group_id: params[:group_id], debitor_id: current_user.id, creditor_id: key[1])
				  	if transaction1
				  		transaction1.amount += value
				  		transaction1.save
				  	elsif transaction2
				  		if transaction2.amount > value
				  			transaction2.amount -= value
				  		elsif transaction2.amount < value
				  			temp = transaction2.debitor_id
				  			transaction2.debitor_id = transaction2.creditor_id
				  			transaction2.creditor_id = temp
				  			transaction2.amount = value - transaction2.amount
				  		else
				  			transaction2.destroy
				  		end
				  		transaction2.save
				  	else
				  		Transaction.create(
				  				group_id: params[:group_id],
				  				debitor_id: key[1],
				  				creditor_id: current_user.id,
				  				amount: value,
				  				status: 'pending',
				  				confirmed_by: 'none' 
				  			)
				  	end
				end
			end
		end
		return redirect_to '/groups' 
	end
end
