Meteor.publish "allusers", (options) ->
   Meteor.users.find()

Meteor.publish "programusers", (programId) ->
   ProgramUsers.find({programId: programId})

Meteor.publish "allprogramusers", (options) ->
  ProgramUsers.find()

Meteor.methods
  UserUpsert: (userId, programId) ->
    timestamp = (new Date()).getTime()
    # Meteor.users.upsert({_id: userId}, {$set: {lastseen: timestamp, lastroom: programId, online: true}})

    ProgramUsers.update(
      {userId: userId, programId: programId},
      {userId: userId, programId: programId, lastseen: timestamp},
      {upsert: true})


helper = ->
    checkTime = ->


      programusers = ProgramUsers.find().fetch()

      for m in programusers
        if !m.lastseen?
          time = parseInt((new Date()).getTime())
        else
          time = parseInt((new Date()).getTime() - m.lastseen)
        #console.log  "id: "+ m._id + ", time lapse: "+ time
        if (time > 10000)
          ProgramUsers.remove({userId: m.userId})

    Fiber = Npm.require('fibers')
    Fiber(-> checkTime()).run()

Meteor.onConnection ->

  setInterval (-> helper()), 10000

