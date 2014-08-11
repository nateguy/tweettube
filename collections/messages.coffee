@Messages = new Meteor.Collection 'messages'

Messages.allow
	insert: (userID, doc) -> true
	update: (userID, doc) -> true
	remove: (userID, doc) -> true
