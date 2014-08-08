Template.tweet.helpers
	allChannels: -> Channels.find({})

Template.tweet.events

	'click .panel-body': (e)->
		Router.go('blab')
		false