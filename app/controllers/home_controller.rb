class HomeController < ApplicationController
  def index
  end

  def profile
    @person = Person.find_by(:user_id => current_user.id)
    @contact = current_user.contact
  end

  def split
    if params[:count] and params[:count] != 0
      @status = true;
      @count = params[:count].to_i
    else
      @status = false
    end
  end

  def evaluate
    data = Array.new
    temp = Array.new
    name = nil
    params.each do |key, value| 
      key = key.split('_')
      if key[1] == 'name'
        temp << value
      elsif key[1] == 'amount'
        temp << value.to_i
        data << temp
        temp = []
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
        result << temp
        temp = []
        data[i][1] = data[i][1] + data[j][1]
        data[j][1] = 0 
        j = j-1
        count += 1
      elsif data[i][1].abs < data[j][1].abs
        temp << data[i][0]
        temp << data[j][0]
        temp << data[i][1].abs
        result << temp
        temp = []
        data[j][1] = data[j][1] + data[i][1]
        data[i][1] = 0
        i = i+1
        count += 1
      else
        temp << data[i][0]
        temp << data[j][0]
        temp << data[i][1].abs
        result << temp
        temp = []
        data[j][1] = 0
        data[i][1] = 0
        i = i+1
        j = j-1
        count += 2
      end
    end
    @result = result
  end

  def create
  end

  def create_profile
  	person = Person.create(
  			user_id: current_user.id,
  			username: params[:username],
  			name: params[:name],
  			gender: params[:gender],
  			dob: params[:dob]
  		)

    if(params[:photo])
      file = params[:photo]
      filename = person.id.to_s + '_' + file.original_filename
      File.open(Rails.root.join('public', 'uploads', 'users', filename), 'wb') do |f|
      f.write(file.read)
      end
      person.photo = file.original_filename
      person.save
    end

  	return redirect_to '/profile'
  end

  def edit
    @person = Person.find_by(:user_id => current_user.id)
    @contact = current_user.contact
  end

  def edit_profile
    person = Person.find_by(user_id: current_user.id)
    if(params[:photo])
      file = params[:photo]
      filename = person.id.to_s + '_' + file.original_filename
      if(person.photo)
        oldfilename = person.id.to_s + '_' + person.photo       
        File.delete(Rails.root.join('public', 'uploads', 'users', oldfilename))
      end
      File.open(Rails.root.join('public', 'uploads', 'users', filename), 'wb') do |f|
      f.write(file.read)
      end
      person.photo = file.original_filename
      person.save
    end
  	person.username = params[:username]
  	person.name = params[:name]
  	person.gender = params[:gender]
  	person.dob = params[:dob]
  	person.save
  	contact = current_user.contact
  	if not contact
  		contact = Contact.new
  		contact.user_id = current_user.id
  	end
  	if(params[:phone] != "")
  		contact.phone = params[:phone]
  		contact.save
  	end
  	if(params[:address] != "")
  		contact.address = params[:address]
  		contact.save
  	end
  	if(params[:city] != "")
  		contact.city = params[:city]
  		contact.save
  	end
  	if(params[:pin] != "")
  		contact.pin = params[:pin]
  		contact.save
  	end
  	return redirect_to '/profile'
  end

  def about
  end
  
end
