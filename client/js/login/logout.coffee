Template.navbar.events
   'click #logout': (e) ->
     Meteor.logout()
     Router.go('login')
     e.preventDefault()
     false