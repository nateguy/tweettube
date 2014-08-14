Router.map ->

  @route 'login', {path: '/'}
  @route 'registration'
  @route 'tweet',
    waitOn: -> [Meteor.subscribe "programs",
          Meteor.subscribe "channels",
          Meteor.subscribe "onlineusers"]
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
      Meteor.call "programApi", this.params.ProgramId,
        (error, results) ->
          programData = trimData(results.data.ProgramDetailsResult.Program)
          Session.set('programData', programData)
      [Meteor.subscribe "programs",
          Meteor.subscribe "programMessages",this.params.ProgramId,
          Meteor.subscribe "onlineusers"]

trimData = (x) ->
  return {ProgramId: x.ProgramHandle.Id, CopyText: x.CopyText, MasterTitle: x.MasterTitle}

autoLogin = (pause) ->
  Router.go 'tweet' if Meteor.userId()

requireLogin = (pause) ->
   unless Meteor.userId()
     Router.go 'login'

Router.onBeforeAction autoLogin,
  only: ['login', 'registration']

Router.onBeforeAction requireLogin,
   only: 'tweet'