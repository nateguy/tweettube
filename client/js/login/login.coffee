Template.login.events

  'submit #login-form': (e, t) ->

    email = t.find('#accounts-email').value
    password = t.find('#accounts-password').value

    console.log email, password

    Meteor.loginWithPassword email, password, (error) ->
      if error
        console.log error
      else
        console.log "logged in as:"
        console.log Meteor.user()
        Router.go 'tweet'

    e.preventDefault()
    false