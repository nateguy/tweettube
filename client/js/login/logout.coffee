Template.navbar.events
   'click #logout': (e) ->
     Meteor.logout()
     unless Meteor.userId()
      Router.go 'login'
     e.preventDefault()
     false