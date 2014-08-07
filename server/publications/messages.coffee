Meteor.publish "messages", (options) ->

	Messages.find()

	
#	Messages.find({email: "nathant12@hotmail.com"}) - filter all messages by email nathant12@hotmail.com

