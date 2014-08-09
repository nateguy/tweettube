getNextFourHours = ->
	timeArray = []
	hours = (new Date()).getHours()
	minutes = (new Date()).getMinutes()

	for i in [0..3]
		if minutes >= 30
			timeArray.push {"time": "#{hours}:30" }
			if (hours + 1) > 23
				hours = 0
			else
				hours = hours + 1
			minutes = 0
		else
			timeArray.push {"time": "#{hours}:00" }
			minutes = 30

	timeArray

getLineup = (channel) ->
	lineup = getNextFourHours()

	channel_programs = []
		#channel_programs = Programs.find({channel_id: this._id, time: times.time}).fetch()
	console.log "you are on " + channel.channel
	for times in lineup
		time = times.time
		t = Programs.find({channel_id: channel._id, time: time}).fetch()
		if t[0] is undefined
			channel_programs.push {}
		else
			channel_programs.push {_id: t[0]._id, time: t[0].time, name: t[0].name, description: t[0].description}
			#current_channel_programs = channel_programs.find({time: times.time})
		
	channel_programs


Template.schedule.times = ->
	getNextFourHours()

Template.tweet.helpers
	allChannels: -> Channels.find({})

Template.channel.helpers
	allPrograms: -> Programs.find({})
	thisChannel: -> getLineup(this)
		

# Template.tweet.events

# 	'click .panel-body': (e, t)->
# 		console.log t
# 		#Router.go('blab')
# 		false