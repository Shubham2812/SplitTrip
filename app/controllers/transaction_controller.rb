class TransactionController < ApplicationController

	def create
	  @group = Group.find(params[:group_id])
	  @members = @group.members

      if params.length > 5
      	  @status = true
		  count = 0;
		  transaction = Transaction.create(
		  		group_id: params[:group_id].to_i,
		  		start_time: DateTime.now.strftime("%H:%M:%S"),
		  		status: 'running',
		  		name: params[:title] 
		  	)

	      data = Array.new
	      temp = Array.new
	      name = nil
	      params.each do |key, value| 
	        key = key.split('_')
	        if value.to_i > 0
		        if key[0] == 'member'
		          temp << Person.find_by(user_id: key[1].to_i).name + '_' + key[1]
		          temp << value.to_i
		          data << temp
		          temp = []
		        elsif key[0] == 'user'
		          temp << User.find(key[1].to_i).email + '_' + key[1]
		          temp << value.to_i
		          data << temp
		          temp = []
		        end
		        count += 1;
		    end
	      end
	      total_amount = 0
	      data.each do |i|
	        total_amount += i[1]
	      end
	      total_people = data.length
	      charge_per_head = (1.0*total_amount)/total_people
	      data.each do |i|
	        i[1] = i[1] - charge_per_head
	      end
	      
	      data = data.sort {|left, right| left[1] <=> right[1] }
	      
	      i = 0;
	      j = data.length - 1
	      temp = []
	      result = []
	      count = 0
	      while count < data.length
	        if data[i][1].abs > data[j][1].abs
	          temp << data[i][0]
	          temp << data[j][0]
	          temp << data[j][1].abs
	          if temp[0] != temp[1]
	            result << temp
	          end
	          temp = []
	          data[i][1] = data[i][1] + data[j][1]
	          data[j][1] = 0 
	          j = j-1
	          count += 1
	        elsif data[i][1].abs < data[j][1].abs
	          temp << data[i][0]
	          temp << data[j][0]
	          temp << data[i][1].abs
	          if temp[0] != temp[1]
	            result << temp
	          end
	          temp = []
	          data[j][1] = data[j][1] + data[i][1]
	          data[i][1] = 0
	          i = i+1
	          count += 1
	        else
	          temp << data[i][0]
	          temp << data[j][0]
	          temp << data[i][1].abs
	          if temp[0] != temp[1]
	            result << temp
	          end
	          temp = []
	          data[j][1] = 0
	          data[i][1] = 0
	          i = i+1
	          j = j-1
	          count += 2
	        end
	      end
	      @result = result
	      result.each do |i|
	      	i[0] = i[0].split('_')
	      	debitor_id = i[0][1]
	      	i[1] = i[1].split('_')
	      	creditor_id = i[1][1]
	      	amount = i[2]
	      	Debt.create(
	      			transaction_id: transaction.id,
	      			debitor_id: debitor_id,
	      			creditor_id: creditor_id,
	      			amount: amount,
	      			status: 'pending'
	      		)
	  	  end
	  else
	  	@status = false
	  end
 
	# 	params.each do |key, value|
	# 		key = key.split("_")
	# 		value = value.to_i
	# 		if(value != 0)
	# 			if(key[0] == 'debit')
	# 			  	transaction1 = Transaction.find_by(group_id: params[:group_id], debitor_id: current_user.id, creditor_id: key[1])
	# 			  	transaction2 = Transaction.find_by(group_id: params[:group_id], debitor_id: key[1], creditor_id: current_user.id)
	# 			  	if transaction1
	# 			  		transaction1.amount += value
	# 			  		transaction1.save
	# 			  	elsif transaction2
	# 			  		if transaction2.amount > value
	# 			  			transaction2.amount -= value
	# 			  		elsif transaction2.amount < value
	# 			  			temp = transaction2.debitor_id
	# 			  			transaction2.debitor_id = transaction2.creditor_id
	# 			  			transaction2.creditor_id = temp
	# 			  			transaction2.amount = value - transaction2.amount
	# 			  		else
	# 			  			transaction2.destroy
	# 			  		end
	# 			  		transaction2.save
	# 			  	else
	# 			  		Transaction.create(
	# 			  				group_id: params[:group_id],
	# 			  				debitor_id: current_user.id,
	# 			  				creditor_id: key[1],
	# 			  				amount: value,
	# 			  				status: 'pending',
	# 			  				confirmed_by: 'none' 
	# 			  			)
	# 			  	end
	# 			elsif(key[0] == 'credit')
	# 			  	transaction1 = Transaction.find_by(group_id: params[:group_id], debitor_id: key[1], creditor_id: current_user.id)
	# 			  	transaction2 = Transaction.find_by(group_id: params[:group_id], debitor_id: current_user.id, creditor_id: key[1])
	# 			  	if transaction1
	# 			  		transaction1.amount += value
	# 			  		transaction1.save
	# 			  	elsif transaction2
	# 			  		if transaction2.amount > value
	# 			  			transaction2.amount -= value
	# 			  		elsif transaction2.amount < value
	# 			  			temp = transaction2.debitor_id
	# 			  			transaction2.debitor_id = transaction2.creditor_id
	# 			  			transaction2.creditor_id = temp
	# 			  			transaction2.amount = value - transaction2.amount
	# 			  		else
	# 			  			transaction2.destroy
	# 			  		end
	# 			  		transaction2.save
	# 			  	else
	# 			  		Transaction.create(
	# 			  				group_id: params[:group_id],
	# 			  				debitor_id: key[1],
	# 			  				creditor_id: current_user.id,
	# 			  				amount: value,
	# 			  				status: 'pending',
	# 			  				confirmed_by: 'none' 
	# 			  			)
	# 			  	end
	# 			end
	# 		end
	# 	end
	# 	return redirect_to '/groups' 
	end

	def change_status
		status = nil
		debt = Debt.find(params[:debt_id])
		if debt.status == 'pending'
			debt.status = 'paid'
			status = true
		else
			debt.status = 'pending'
			status = false
		end
		debt.save

		render json: status
	end

end
