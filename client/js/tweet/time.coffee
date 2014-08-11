Template.schedule.times = ->
	timeArray = []
	hours = (new Date()).getHours()
	minutes = (new Date()).getMinutes()

	for i in [0..3]
		if minutes >= 30
			timeArray.push {"time": "#{hours}:30" }
			hours = hours + 1
			minutes = 0
		else
			timeArray.push {"time": "#{hours}:00" }
			minutes = 30
	console.log timeArray
	timeArray


