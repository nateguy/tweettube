Template.navbar.events
   'click #logout': (e) ->
     Meteor.logout()

     Router.go {path: '/'}
     e.preventDefault()
     false