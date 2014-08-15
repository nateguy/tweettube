

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

getProgramId = ->
	programData = Session.get('programData')
	return programData.ProgramId

getOnlineUsers = ->
	return ProgramUsers.find().fetch()

Template.blab.helpers
	allMessages: -> Messages.find({})
	allUsers: ->
		return Meteor.users.find({})
	onlineUsers: ->
		return getOnlineUsers()
	getTitle: -> return getTitle()
	getDescription: -> return getDescription()

Template.onlineuser.helpers
	isOnline: ->
		return this.online
	nickname: ->

		user = Meteor.users.find(this.userId).fetch()

		return user[0].profile.name

Template.message.helpers
	profileImageThumb: () ->
    Images.findOne({_id: Meteor.user().profile.image}).url({store: 'thumbs'})

	timeposted: ->
		current_time = new Date()
		posted_time = new Date(this.timestamp)
		return Math.round((current_time - posted_time) / 60000)

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

Template.blab.rendered = ->
	Meteor.call('UserUpsert', Meteor.user()._id, getProgramId() )

Template.message.rendered = ->

	$(document).scrollTop( $(document).height() )
	t = 0
	if this.data.responses
		t = this.data.responses.length

	if t == 0
		$(".counter_reply.#{this.data._id}").html("Reply")
	else
		$(".counter_reply.#{this.data._id}").html(t + " Replies")


	#Meteor.call('UserUpsert', Meteor.user()._id, getProgramId() )
	setInterval (-> Meteor.call('UserUpsert', Meteor.user()._id, getProgramId() )), 5000


Template.message.events
	'click #seereplies': (e) ->
		console.log e.currentTarget.parentElement.nextElementSibling.nextElementSibling
		replies_element = e.currentTarget.parentElement.nextElementSibling.nextElementSibling
		console.log replies_element.style.display
		if replies_element.style.display is ""
			replies_element.style.display = "table-cell"
		else
			replies_element.style.display = ""
		e.preventDefault()
		false

	'click #deletereply': (e) ->
		confirm_delete = confirm "Are you sure you want to delete this message?"
		if confirm_delete
			Messages.update(this.messageId, {$pull: {'responses': {responseIndex: this.responseIndex}}})
		e.preventDefault()
		false

	'click #deletemessage': (e) ->
		confirm_delete = confirm "Are you sure you want to delete this message?"
		if confirm_delete and (this.userId == Meteor.userId())
			Messages.remove this._id
		e.preventDefault()
		false


Template.blab.events

	'click #logout': (e)->
		Meteor.logout()
		Router.go('login')
		e.preventDefault()
		false

Template.reply_box.events
	'submit .reply-box': (e, t) ->
		input = t.find('#reply-box-content')

		message = input.value
		user = Meteor.userId()

		input.value = ""
		time = (new Date()).getTime()
		if !Messages.findOne(t.data._id).responses
			responses_array_index = 0
		else
			responses_array_index = Messages.findOne(t.data._id).responses.length
		Messages.update({_id:t.data._id},
			{$addToSet: {responses: {messageId: t.data._id, responseIndex: responses_array_index, userId: user, content: message, timestamp: time}}})
		e.preventDefault()
		false

Template.message_box.events
	'submit #message-box-form': (e, t) ->

		input = t.find('#message-box-content')
		message = input.value
		userId = Meteor.userId()
		program = getProgramId()
		input.value = ""

		Messages.insert(postMessage(userId, message, program))

		e.preventDefault()
		false
