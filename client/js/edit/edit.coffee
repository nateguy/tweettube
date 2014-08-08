
# Template.upload.events
#   "dropped #dropzone": (event, temp) ->
#     console.log "files dropped"

#     FS.Utility.eachFile event, (file) ->
#       Images.insert file, (err, fileObj) ->
#         console.log "inserted"

#   # Uploads = Images.find.fetch()[0]
#   #   uploads.isImage()
#   #     if uploads.isImage() == true
#   #       puts "upload"
#   #     else
#   #       alert "Image is not uploaded"
# Template.registration.helpers
#   profileImage: () -> Images.find().fetch()[0].url()


# return





# var Images = new FS.Collection("images", {
#   stores: [new FS.Store.FileSystem("images", {path: "~/uploads"})]
# });

# Template.myForm.events "change .myFileInput": (event, template) ->
#   FS.Utility.eachFile event, (file) ->
#     Images.insert file, (err, fileObj) ->


Template.edit.events

  'submit #edit-form': (e, t) ->

    nickname = t.find("#accounts-nickname").value
    age = t.find("#accounts-age").value
    gender = t.find("#accounts-gender").value
    favorite = t.find("#accounts-favorite").value

    console.log nickname, age, gender, favorite

    Meteor.users.update( Meteor.userId(), { $set: {"profile.name":nickname, "profile.age":age, "profile.gender":gender, "profile.favorite":favorite}})

    e.preventDefault()
    false