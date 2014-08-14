
getLineupTimes = ->
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


getAiringStartTime = (program) ->
	return new Date(program.AiringTime)

getAiringEndTime = (program) ->
	airingEndTime = getAiringStartTime(program)
	return new Date(airingEndTime.setMinutes(getAiringStartTime(program).getMinutes() + program.Duration))

getLineup = (channel) ->
	programs = []

	#remove all airings that start after the end of the 2 hour window
	for program in channel.Airings
		unless getAiringStartTime(program) >= getEndTimeSlot()
			console.log program
			programs.push program
	programs


getChannels = ->
<<<<<<< HEAD

		channels = []
		temp = Session.get('schedules')
		for i in [0..(temp.length-1)]
			channels.push temp[i]
		console.log channels
		return channels

=======
		
	channels = []
	channels = Session.get('schedules')
	return channels

#returns milliseconds
getEndTimeSlot = ->

	EndTimeSlot = new Date(getCurrentTimeSlot())
	return new Date(EndTimeSlot.setHours(getCurrentTimeSlot().getHours() + 2))

#returns milliseconds
getCurrentTimeSlot = ->
	t = new Date()
	hours = t.getHours()
	minutes = t.getMinutes()
	year = t.getFullYear()
	month = t.getMonth()
	day = t.getDate()

	if minutes >= 30
		return new Date(year, month, day, hours, 30, 0)
	else
		return new Date(year, month, day, hours, 0, 0)
>>>>>>> upstream/master

Template.schedule.times = ->
	getLineupTimes()

Template.program.events
	'click .program': (e, t) ->
		console.log this
		Router.go('blab', {ProgramId: this.ProgramId, title: this.Title})
		e.preventDefault()
		false

Template.tweet.helpers
	allChannels: -> getChannels()

Template.channel.helpers
	allPrograms: -> Programs.find({})
	thisChannel: -> getLineup(this)

Template.program.helpers
<<<<<<< HEAD
	timewidth: ->

		console.log this.time
		return 0

=======
	duration: -> 

		currentTimeSlot = new Date(getCurrentTimeSlot())
		EndTimeSlot = getEndTimeSlot()

		airingStartTime = new Date(this.AiringTime)
		airingEndTime = getAiringEndTime(this)

		currentTimeSlotDiscreptancy = (airingStartTime - currentTimeSlot) / 60000

		if currentTimeSlotDiscreptancy < 0
			return Math.round((currentTimeSlotDiscreptancy + this.Duration) / 10)
		else
			if airingEndTime > EndTimeSlot
				return Math.floor(((EndTimeSlot - airingStartTime) / 60000) / 10)
			else
				return Math.round(this.Duration / 10)
>>>>>>> upstream/master

# Template.tweet.events

# 	'click .panel-body': (e, t)->
# 		console.log t
# 		#Router.go('blab')
# 		false