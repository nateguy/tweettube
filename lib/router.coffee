Router.map ->

  @route 'login', {path: '/'}
  @route 'registration'
  @route 'tweet',
    waitOn: -> [Meteor.subscribe "programs",
          Meteor.subscribe "channels"]
  @route 'edit'
  @route 'addChannel',
    waitOn: -> Meteor.subscribe "channels"

  @route 'test'

  @route 'addProgram',
    waitOn: -> [Meteor.subscribe "programs",
          Meteor.subscribe "channels"]
  @route 'blab',
    path: 'blab/:ProgramId',
    data: -> return {
      title: this.params.title
      },
    waitOn: ->
      Session.set('programId', this.params.ProgramId)
      [Meteor.subscribe "programs",
          Meteor.subscribe "programMessages",this.params.ProgramId,
          Meteor.subscribe "onlineusers"]

autoLogin = (pause) ->
  Router.go 'tweet' if Meteor.userId()

requireLogin = (pause) ->
   unless Meteor.userId()
     Router.go 'login'

Router.onBeforeAction autoLogin,
  only: ['login', 'registration']

Router.onBeforeAction requireLogin,
   only: 'tweet'