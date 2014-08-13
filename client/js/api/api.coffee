$ ->
	console.log "loading..."
	if Meteor.isClient
			Meteor.call "RoviApi", 
			(error, results) ->
				Session.set('schedules', results.data.GridScheduleResult.GridChannels)
	#console.log Session.get('schedules')
