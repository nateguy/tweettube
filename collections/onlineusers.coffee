@onlineUsers = Meteor.users

onlineUsers.allow
	insert: (userID, doc) -> true
	update: (userID, doc) -> true
#	remove: (userID, doc) -> true
