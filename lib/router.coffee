Router.map ->
  @route 'registrationForm', { path: 'registration' }
  @route 'loginForm', { path: '/' }
  @route 'blab',
    path: 'blab',
    waitOn: -> [Meteor.subscribe "messages",
    			Meteor.subscribe "onlineusers"]

autoLogin = (pause) ->
	Router.go 'blab' if Meteor.userId()

requireLogin = (pause) ->
	Router.go 'loginForm' unless Meteor.userId()

Router.onBeforeAction autoLogin,
	only: ['loginForm', 'registrationForm']

Router.onBeforeAction requireLogin,
	only: 'blab'