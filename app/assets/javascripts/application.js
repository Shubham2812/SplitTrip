// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function main(){
	// var add_participant = document.getElementsByClassName("add_participant")[0]
	var remove_participant = document.getElementsByClassName("remove_participant")
	var make_admin_participant = document.getElementsByClassName("make_admin_participant")
	
	// if(add_participant)
	// {	console.log("add_participant")
	// 	add_participant.addEventListener("submit", function(event){
	// 		event.preventDefault();
	// 		console.log(event)
	// 		console.log(this)
	// 		var url = '/groups/participant/add'
	// 		var info = {
	// 			username: this[2].value,
	// 			group_id: this.id.slice(9)
	// 		}

	// 		var current_element = this

	// 		$.ajax({
	// 			url: url,
	// 			method: 'post',
	// 			data: info,
	// 			success: function(data){
	// 				console.log(data);
	// 				if(data.status)
	// 				{	var members_list = document.getElementById("members_list")
	// 					var list_item = document.createElement("li");
						
	// 					var inner_element1 = document.createElement("span");
	// 					if(data.person)
	// 						var text1 = document.createTextNode(data.person.name + " ");
	// 					else
	// 						var text1 = document.createTextNode(data.user.email + " ");

	// 					inner_element1.appendChild(text1);

	// 					var inner_element2 = document.createElement("span");
	// 					var text2 = document.createTextNode("member ")
	// 					inner_element2.appendChild(text2);

	// 					var inner_element3 = document.createElement("a");
	// 					inner_element3.setAttribute('href',"/groups/participant/remove");
	// 					inner_element3.className = 'remove_participant'
	// 					inner_element3.id = 'participant_' + data.groups_users_id
	// 					inner_element3.innerHTML = 'Remove '

	// 					var inner_element4 = document.createElement("a");
	// 					inner_element4.setAttribute('href',"/groups/participant/make_admin");
	// 					inner_element4.className = 'make_admin_participant'
	// 					inner_element4.id = 'participant_' + data.groups_users_id
	// 					inner_element4.innerHTML = 'Make Admin'

	// 					list_item.appendChild(inner_element1)
	// 					list_item.appendChild(inner_element2)
	// 					list_item.appendChild(inner_element3)
	// 					list_item.appendChild(inner_element4)
	// 					members_list.appendChild(list_item)

	// 					current_element[2].value = ""
	// 				}
	// 				else
	// 				{
	// 					document.getElementById('result').innerHTML = data.message
	// 				}
	// 			},
	// 			error: function(){
	// 				alert("Error")
	// 			}
	// 		})
	// 	})
	// }

	if(remove_participant.length > 0)
	{	for(var i=0; i<remove_participant.length; i++)
		{	remove_participant[i].addEventListener("click", function(event){
				event.preventDefault();
				var members_count = document.getElementById("members_count")
				var count = members_count.innerHTML - 1;
				var url = '/groups/participant/remove'
				var info = {
					groups_users_id: this.id.slice(7)
				}

				var current_element = this
				$.ajax({
					url: url,
					method: 'post',
					data: info,
					success: function(){
						var child = current_element.parentElement.parentElement.parentElement.parentElement
						var parent = child.parentElement
						parent.removeChild(child)
						members_count.innerHTML = count;
					},
					error: function(){
						alert("Error")
					}
				})
			})
		}
	}

	if(make_admin_participant.length > 0)
	{
		for(var i=0; i<make_admin_participant.length; i++)
		{	make_admin_participant[i].addEventListener("click", function(event){
				event.preventDefault();				
				var elem = this.parentElement.parentElement.previousElementSibling.lastElementChild
				var url = '/groups/participant/make_admin'
				var info = {
					groups_users_id: this.id.slice(11)
				}
				$.ajax({
					url: url,
					method: 'post',
					data: info,
					success: function(){
						elem.style.color = '#8b8080'
						elem.innerHTML = "admin"
					},
					error: function(){
						alert("Error")
					}
				})
			})
		}
	}

	$(function(){
  		var faye = new Faye.Client('http://localhost:9292/faye');
  		faye.subscribe("/messages/new", function(data) {
    		var url = '/abc'
    		var info = {
    			user: data.user,
    			message: data.message
    		}

    		$.ajax({
    			url: url,
    			method: 'post',
    			data: info,
    			success: function(){

    			},
    			error: function(){
    				alert("Error")
    			}
    		})

			// $('.chat_window').append('<div>'+ data.message.content + ',' + data.user.email + '</div>');
  		});

  		// faye.publish('/messages/new', {text: 'Hi there'});
	});

	var chat_window = document.getElementsByClassName("chat_window")[0];
	if(chat_window)
	{
		chat_window.scrollTop = chat_window.scrollHeight
	}

	var search_form = document.getElementById('participant_username');
	if(search_form)
	{	search_form.addEventListener('keydown', function(){
			var search_results = document.getElementById('search_results')
			if(search_form.value.length > 0)
			{
				var url = '/search'
				var info = {
					search: search_form.value
				}

				search_results.style.display = 'block'

				$.ajax({
					url: url,
					method: 'post',
					data: info,
					success: function(users){
						console.log(users);
						while (search_results.firstChild) 
						{ search_results.removeChild(search_results.firstChild);
						}

						for(var i=0; i<users.length; i++)
						{ var child = document.createElement('div')
						  var identity = null

						  if(users[i].username)
						  	identity = users[i].username
						  else
						  	identity = users[i].email

						  var text = document.createTextNode(identity)

						  child.appendChild(text);
						  search_results.appendChild(child)
						  child.addEventListener('click', function(){
						  	search_form.value = this.innerHTML
						  })
						}
					},
					error: function(){
						alert("Error")
					}
				})
			}
			else
			{
				search_results.style.display = 'none'
			}
		})
	}

	// search_form.addEventListener('focus', function(){
	// 	this.style.border = '0px';
	// 	console.log("focussed")
	// })

	var search_results = document.getElementById('search_results')
	if(search_results)
	{ 
		search_results.addEventListener('click', function(){
			this.style.display = 'none'
		})

		document.body.addEventListener('click', function(event){
			var search_results = document.getElementById('search_results')  
			var x = $("#search_results").position();

			if((event.clientX < x.left || event.clientX > x.left + search_results.clientWidth) || (event.clientY < x.top || event.clientY > x.top + search_results.clientHeight))
			search_results.style.display = 'none'
			
		})
	}

	var transaction_status = document.getElementsByClassName('transaction_status')
	if(transaction_status.length > 0)
	{
		for(var i=0; i<transaction_status.length; i++)
		{
			transaction_status[i].addEventListener('click', function(event){
				console.log(event);
				event.preventDefault();
				var url = '/transaction/payment/status';
				var info = {
					debt_id: this.id.slice(5)
				}
				var current_element = this;
				$.ajax({
					url: url,
					method: 'get',
					data: info,
					success: function(status){
						if(status)
						{	current_element.parentElement.previousElementSibling.innerHTML = 'paid'
							current_element.firstChild.src = '/images/cross.png'
							current_element.parentElement.parentElement.style.backgroundColor = 'lightgreen'
							current_element.parentElement.parentElement.style.color = 'darkgreen'
						}
						else
						{
							current_element.parentElement.previousElementSibling.innerHTML = 'pending'
							current_element.firstChild.src = '/images/tick.png'
							current_element.parentElement.parentElement.style.backgroundColor = 'pink'
							current_element.parentElement.parentElement.style.color = 'red'
						}
						
						current_element.style.backgroundColor = 'white';


					},
					error: function(){
						alert('Error');
					}
				})

			})
		}
	}

	// var toggleTransaction = document.getElementsByClassName("toggleTransaction")
	// if(toggleTransaction.length > 0)
	// {	
	// 	for(var i=0; i<toggleTransaction.length; i++)
	// 	{	var status = false;
	// 		console.log($('#upDownTransaction_' + i)[0]);
	// 		var j = i;
	// 		toggleTransaction[i].addEventListener('click', function(){
	// 			console.log($('#upDownTransaction_' + j)[0]);
	// 			$('#upDownTransaction_' + j)[0].toggle(500);
	// 			if(status)
	// 			this.lastElementChild.src = '/images/up_arrow.ico';
	// 			else
	// 			this.lastElementChild.src = '/images/down_arrow.png';
	// 			status = !status
	// 		})
	// 	}
	// }

}

window.addEventListener("load", function(){
	main();
})
