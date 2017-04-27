require 'rest-client'
class ChatController < ApplicationController
  def index
  	@messages = Message.all
  end

  def new_message
  	message = current_user.messages.create(
  			content: params[:message]
  		)
  	respond_to do |format|
		format.js{
			data = Hash.new
			data["user"] = current_user
			data["message"] = message
			message = {:channel => "/messages/new", :data => data}
			response = RestClient.post("http://localhost:9292/faye", message.to_json, "content-type":"application/json")
			# uri = URI.parse("http://localhost:9292/faye")
			# Net::HTTP.post_form(uri, :message => message.to_json)
		}
	end  	
  end

  def append_message
  	@user = User.find(params[:user][:id])
  	@message = Message.find(params[:message][:id])
  	respond_to do |format|
  		format.js{

  		}
  	end	
  end
end
