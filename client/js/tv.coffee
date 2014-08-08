Template.tweet.helpers
	allChannels: -> Channels.find({})

Template.tweet.events

	'click #collapseOne': (e)->
		Router.go('blab')
		false