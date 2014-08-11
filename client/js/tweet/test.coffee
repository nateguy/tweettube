
Template.addChannel.events

  'submit #channel-form': (e, t) ->

    channel = t.find('#channel-name').value
    
    Channels.insert({ channel: channel})

    e.preventDefault()
    false


Template.addProgram.events

  'submit #program-form': (e, t) ->

    channel = t.find('#channel-name').value
    hour = t.find('#program-hour').value
    minute = t.find('#program-minute').value
    name = t.find('#program-name').value
    description = t.find('#program-description').value
    time = hour + ":" + minute
    #Programs.update({_id: channel},
    #        {$addToSet: {programs: {name: name, time: time}}})
    
    Programs.insert({channel_id: channel, time: time, name: name, description: description})
    console.log 
    e.preventDefault()
    false

Template.addProgram.channels = ->
 	return Channels.find({})

Template.addProgram.hours = ->
 	hours = []
 	for i in [0..23]
 		hours.push {"hour": i}
 	return hours

Template.addProgram.minutes = ->
 	minutes = [{"minute": "00"},{"minute": "30"}]
 	return minutes
 	