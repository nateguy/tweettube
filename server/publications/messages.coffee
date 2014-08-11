Meteor.publish "messages", (options) ->

	Messages.find()

Meteor.publish "programMessages", (program) ->
    Messages.find({programId: program})