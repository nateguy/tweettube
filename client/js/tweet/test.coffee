
Template.addChannel.events

  'submit #channel-form': (e, t) ->

    channel = t.find('#channel-name').value
    program1 = t.find('#prog-1').value
    program2 = t.find('#prog-2').value
    program3 = t.find('#prog-3').value
    program4 = t.find('#prog-4').value
    
    Channels.insert({ channel: channel, program1: program1, program2: program2, program3: program3, program4: program4})

    e.preventDefault()
    false


Template.addProgram.events

  'submit #program-form': (e, t) ->

    channel = t.find('#channel-name').value
    hour = t.find('#program-hour').value
    minute = t.find('#program-minute').value
    name = t.find('#program-name').value
    time = hour + ":" + minute
    #Programs.update({_id: channel},
    #        {$addToSet: {programs: {name: name, time: time}}})
    
    Programs.insert({channel_id: channel, time: time, name: name})
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
 	