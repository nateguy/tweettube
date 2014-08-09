Router.map ->

  @route 'login', {path: '/'}
  @route 'registration'
  @route 'tweet',
    waitOn: -> [Meteor.subscribe "programs",
          Meteor.subscribe "channels"]
  @route 'edit'
  @route 'addChannel',
    waitOn: -> Meteor.subscribe "channels"
  @route 'addProgram',
    waitOn: -> [Meteor.subscribe "programs",
          Meteor.subscribe "channels"]
  @route 'blab',
    path: 'blab',
    waitOn: -> [Meteor.subscribe "messages",
    			Meteor.subscribe "onlineusers"]



#   @route 'blab',
    # waitOn: -> Meteor.subscribe "messages"

autoLogin = (pause) ->
  Router.go 'tweet' if Meteor.userId()

requireLogin = (pause) ->
   unless Meteor.userId()
     Router.go 'login'

Router.onBeforeAction autoLogin,
  only: ['login', 'registration']

Router.onBeforeAction requireLogin,
   only: 'tweet'