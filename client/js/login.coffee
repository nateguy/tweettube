getEmail = ->
	Meteor.user().emails[0].address

Template.loginForm.events

	'submit #login-form': (e, t) ->

		email = t.find('#accounts-email').value
		password = t.find('#accounts-password').value

		console.log email, password

		Meteor.loginWithPassword email, password, (error) ->
			if error
				console.log "error"
			else

				console.log "logged in as"
				i = Meteor.user()
				console.log "inserting" + Meteor.user()._id
				#Meteor.call( 'UserUpsert', Meteor.userId() )
				#onlineUsers.upsert(Meteor.userId(), { email: getEmail(), online: true})
				console.log onlineUsers.find({})				
				Router.go('blab')

		e.preventDefault()
		false
