
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
