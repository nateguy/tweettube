Meteor.publish "messages", (options) ->

	Messages.find()

Meteor.publish "programMessages", (program) ->
    Messages.find({programId: program})

Meteor.publish "images", (options) ->
    Images.find()

Meteor.publish "thumbs", (options) ->
    Images.find()
