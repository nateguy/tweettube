@Messages = new Meteor.Collection 'messages'

Messages.allow
	insert: (userID, doc) -> true
	update: (userID, doc) -> true
	remove: (userID, doc) -> true

#Messages.find().observe
#	added: ->
#		$('#count').html(Messages.find().count())
#	changed: ->
#		alert('document changed')
#	removed: ->
#		alert('remove')