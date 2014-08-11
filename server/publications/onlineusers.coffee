Meteor.publish "onlineusers", (options) ->
  Meteor.users.find()


Meteor.methods
	UserUpsert: (id, email) ->
		
    timestamp = (new Date()).getTime()
    Meteor.users.upsert({_id: id}, {$set: {lastseen: timestamp, online: true}})

helper = ->
    checkTime = ->
      onlineusers = Meteor.users.find().fetch()
      for m in onlineusers
        if !m.lastseen?
          time = parseInt((new Date()).getTime())
        else
          time = parseInt((new Date()).getTime() - m.lastseen)
        console.log  "id: "+ m._id + ", time lapse: "+ time
        if (time < 10000)
      #     console.log "change to false" + m.email
      #     console.log m
          Meteor.users.upsert({_id:m._id}, {$set: {online:true}})
        else
          Meteor.users.upsert({_id:m._id}, {$set: {online:false}})          


    Fiber = Npm.require('fibers')
    Fiber(-> checkTime()).run()
    console.log "reached helper"
    
      # console.log Meteor.users.find().fetch()
      # for i in Meteor.users.find().fetch()
        # console.log "onlineusers"
      # for m in onlineusers
      #   time = parseInt((new Date()).getTime() - m.lastseen)
      #   console.log email + " " + time + "id: "+ _id
      #   if (time > 1000)
      #     console.log "change to false" + m.email
      #     console.log m
      #     Meteor.users.upsert({_id:m._id}, {$set: {online:false}})


Meteor.onConnection ->

  console.log "new connection"
  setInterval (-> helper()), 10000
  console.log "passed setinterval"
