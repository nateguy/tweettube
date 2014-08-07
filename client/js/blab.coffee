

getEmail = ->
	Meteor.user().emails[0].address

postMessage = (email, content) ->
	{ email: email, content: content }

counter_reply = ->
	$('.counter_reply').html(Messages.find().count())
	return false

Template.blab.current_email = ->
	console.log this
	return getEmail() == this.email

Template.blab.helpers
	allMessages: -> Messages.find({})
	allUsers: -> Meteor.users.find({})

Template.onlineuser.helpers
	isOnline: ->
		return this.online
	email: ->
		return this.emails[0].address
#	console.log onlineUsers.find({})

Template.message.helpers
	belongstoUser: ->
		return (this.email == getEmail())

Template.blab.rendered = ->
	

Template.message.rendered = ->
	#j = new Deps.Dependancy
	
	#	j.changed()
	
	$(document).scrollTop( $(document).height() )
	t = 0
	if this.data.responses
		t = this.data.responses.length

	if t == 0
		$(".counter_reply.#{this.data._id}").html("Reply")
	else
		$(".counter_reply.#{this.data._id}").html(t + " Replies")
	
	console.log "You are connected? " + Meteor.status().connected
	console.log Meteor.user()._id

	Meteor.call('UserUpsert', Meteor.user()._id, getEmail())
	setInterval (-> Meteor.call('UserUpsert', Meteor.user()._id, getEmail() )), 5000
	console.log 
	

Template.message.events
	'click #seereplies': (e) ->

		replies_element = e.currentTarget.parentElement.parentElement.children[1]
		if replies_element.style.display is ""
			replies_element.style.display = "table-cell"
		else
			replies_element.style.display = ""
	'click #deletereply': (e) ->
		confirm_delete = confirm "Are you sure you want to delete this message?"
		if confirm_delete and (this.email == getEmail())
			Messages.remove this._id
		e.preventDefault()
		false

	'click #reply': (e) ->
		console.log "reply"
		console.log this._id
		t = prompt "Reply message:"
		email = getEmail()
		Messages.update({_id:this._id},
			{$addToSet: {responses: {email: email, content: t}}})
		console.log this



Template.blab.events

	'click #logout': (e)->
		console.log "logged out"
		console.log this._id
		Meteor.logout()
		Router.go('loginForm')
		e.preventDefault()
		false

Template.reply_box.events
	'submit .reply-box': (e, t) ->

		console.log e.currentTarget

		input = t.find('#reply-box-content')

		message = input.value
		email = getEmail()

		input.value = ""
		Messages.update({_id:t.data._id},
			{$addToSet: {responses: {email: email, content: message}}})
		
		e.preventDefault()
		false 

Template.message_box.events
	'submit #message-box-form': (e, t) ->

		input = t.find('#message-box-content')
		message = input.value
		email = getEmail()
		responses = {}
		input.value = ""

		Messages.insert(postMessage(email, message))

		e.preventDefault()
		false 

	'click #clearAllMsgs': (e) ->
		messages = Messages.find({}).fetch()
		for m in messages
			id = m._id
			console.log id
			Messages.remove id
		e.preventDefault()
		false
