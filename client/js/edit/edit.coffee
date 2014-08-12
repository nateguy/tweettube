Template.upload.events
  "dropped #dropzone": (event, temp) ->
    console.log "files dropped"

    FS.Utility.eachFile event, (file) ->
      Images.insert file, (err, fileObj) ->
        Meteor.users.update(Meteor.userId(), { $set: {"profile.image": fileObj._id}})

        console.log "inserted"

Template.edit.helpers
  profileImage: () ->
    Images.findOne({_id: Meteor.user().profile.image}).url()


Template.edit.events

  'submit #edit-form': (e, t) ->

    nickname = t.find("#accounts-nickname").value
    age = t.find("#accounts-age").value
    gender = t.find("#accounts-gender").value
    favorite = t.find("#accounts-favorite").value

    console.log nickname, age, gender, favorite

    Meteor.users.update( Meteor.userId(), { $set:
      "profile.name":nickname,
      "profile.age":age,
      "profile.gender":gender,
      "profile.favorite":favorite
    })

    e.preventDefault()
    false





