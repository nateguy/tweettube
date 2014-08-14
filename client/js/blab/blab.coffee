

getEmail = ->
	Meteor.user().emails[0].address

postMessage = (user, content, program) ->
	time = (new Date()).getTime()
	{ userId: user, content: content, programId: program, timestamp: time}

counter_reply = ->
	$('.counter_reply').html(Messages.find().count())
	return false

getTitle = ->
	programData = Session.get('programData')
	return programData.MasterTitle

getDescription = ->
	programData = Session.get('programData')
	return programData.CopyText

getID = ->
	programData = Session.get('programData')
	console.log programData
	return programData.ProgramHandle.Id

Template.blab.helpers
	allMessages: -> Messages.find({})
	allUsers: -> Meteor.users.find({})
	getTitle: -> return getTitle()
	getDescription: -> return getDescription()

Template.onlineuser.helpers
	isOnline: ->
		return this.online
	email: ->
		return this.emails[0].address


Template.message.helpers
	belongstoUser: ->
		return (this.userId == Meteor.userId())
	replies: ->
		if this.responses
			return this.responses.length
		else
			return 0
	nickname: ->
		user = Meteor.users.find(this.userId).fetch()
		return user[0].profile.name


Template.message.rendered = ->

	$(document).scrollTop( $(document).height() )
	t = 0
	if this.data.responses
		t = this.data.responses.length

	if t == 0
		$(".counter_reply.#{this.data._id}").html("Reply")
	else
		$(".counter_reply.#{this.data._id}").html(t + " Replies")
	
	console.log Meteor.user()._id + " is online"

	Meteor.call('UserUpsert', Meteor.user()._id, getEmail())
	setInterval (-> Meteor.call('UserUpsert', Meteor.user()._id, getEmail() )), 5000
	

Template.message.events
	'click #seereplies': (e) ->
		console.log e.currentTarget.parentElement.nextElementSibling
		replies_element = e.currentTarget.parentElement.nextElementSibling
		if replies_element.style.display is ""
			replies_element.style.display = "table-cell"
		else
			replies_element.style.display = ""

	'click #deletereply2': (e) ->
		confirm_delete = confirm "Are you sure you want to delete this message?"
		if confirm_delete
			this.remove()
		console.log this.parentElement
		e.preventDefault()
		false

	'click #deletereply': (e) ->
		confirm_delete = confirm "Are you sure you want to delete this message?"
		if confirm_delete and (this.userId == Meteor.userId())
			Messages.remove this._id
		e.preventDefault()
		false



	# 'click #reply': (e) ->
	# 	console.log "reply"
	# 	console.log this._id
	# 	t = prompt "Reply message:"
	# 	email = getEmail()
	# 	Messages.update({_id:this._id},
	# 		{$addToSet: {responses: {email: email, content: t}}})
	# 	console.log this



Template.blab.events

	'click #logout': (e)->
		console.log "logged out"
		console.log this._id
		Meteor.logout()
		Router.go('login')
		e.preventDefault()
		false

Template.reply_box.events
	'submit .reply-box': (e, t) ->

		console.log e.currentTarget

		input = t.find('#reply-box-content')

		message = input.value
		user = Meteor.userId()

		input.value = ""
		Messages.update({_id:t.data._id},
			{$addToSet: {responses: {userId: user, content: message}}})
		
		e.preventDefault()
		false 

Template.message_box.events
	'submit #message-box-form': (e, t) ->

		input = t.find('#message-box-content')
		message = input.value
		userId = Meteor.userId()
		program = getID()
		input.value = ""

		Messages.insert(postMessage(userId, message, program))

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
