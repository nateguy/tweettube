Template.navbar.events
   'click #logout': (e) ->
     Meteor.logout()

     Router.go('/')
     e.preventDefault()
     false