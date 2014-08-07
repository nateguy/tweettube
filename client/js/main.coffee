
getEmail = ->
	Session.get(Meteor.user().emails[0].address)
