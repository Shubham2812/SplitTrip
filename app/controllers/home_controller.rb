class HomeController < ApplicationController
  def index
  end

  def profile
    @person = Person.find_by(:user_id => current_user.id)
    @contact = current_user.contact
  end

  def create
  end

  def create_profile
    byebug
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
end
