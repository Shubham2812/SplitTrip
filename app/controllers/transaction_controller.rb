class TransactionController < ApplicationController

	def evaluate
		byebug
		params.each do |key, value|
			key = key.split("_")
			print key
			puts
			if(value != 0)
				if(key[0] == 'debit')
				  	transaction = Transaction.find_by(group_id: params[:group_id], debitor_id: current_user.id, creditor_id: key[2])
				  	if(transaction)
				  		if(key[1] == 'user')			  
				  			
				  		elsif(key[1] == 'person')
				  		end
				  	else

				  	end
				elsif(key[0] == 'credit')
				  	if(key[1] == 'user')
				  	elsif(key[1] == 'person')
				  	end
				end
			end
		end
		return redirect_to '/groups' 
	end
end
