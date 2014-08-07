MinimumPasswordLength = 4

getEmail = ->
	Meteor.user().emails[0].address

passwordConfirmed = (password, confirm) ->
	password == confirm

passwordIsValid = (password) ->
	password.length >= MinimumPasswordLength

createUser = (email, password) ->
	{ email: email, password: password }

Template.registrationForm.events
	'submit #registration-form': (e, t) ->

		email = t.find('#accounts-email').value
		password = t.find('#accounts-password').value
		confirm = t.find('#accounts-confirm').value

		if passwordIsValid(password)
		
			if passwordConfirmed(password, confirm)
				user = createUser(email, password)

				Accounts.createUser user, (error) ->
					if error
						console.log error
					else
						console.log "success. Logged in as:"
						console.log Meteor.user()
					#	alert "inserting" + Meteor.user()._id
					#	onlineUsers.insert({userId: Meteor.userId(), email: getEmail(), online: true})
					#	console.log onlineUsers.find({})
			else
				console.log "invalid password"
		else
			console.log "password and confirmation do not match"

		e.preventDefault()
		false
	