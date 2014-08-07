MinimumPasswordLength = 6

passwordIsConfirmed = (password, confirm) ->
  password == confirm

passwordIsValid = (password) ->
  password.length >= MinimumPasswordLength

createUser = (email, password) ->
  { email: email, password: password}

Template.registration.events

  'submit #registration-form': (e, t) ->

    email = t.find('#accounts-email').value
    password = t.find('#accounts-password').value
    nickname = t.find('#accounts-nickname').value
    age = t.find('#accounts-age').value
    gender = t.find('#accounts-gender').value
    favorite = t.find('#accounts-favorite').value
    confirm = t.find('#accounts-confirm').value

    console.log "email: " + email, "password: " + password, "nickname: " + nickname, "age: " + age, "gender: " + gender, "Genre: " + favorite, confirm

    if passwordIsValid(password)
      if passwordIsConfirmed(password, confirm)
        user = createUser(email, password)
        Accounts.createUser user, (error) ->
          if error
            console.log error
          else
            Meteor.users.update({_id:Meteor.user()._id}, {$set:{"profile.name":nickname, "profile.age":age, "profile.gender":gender, "profile.favorite":favorite}})

    e.preventDefault()
    false