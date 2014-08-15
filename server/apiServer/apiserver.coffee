if Meteor.isServer
    Meteor.methods
        RoviApi: ->
          this.unblock()
          return Meteor.http.call("GET", "http://api.rovicorp.com/TVlistings/v9/listings/gridschedule/20518/info?apikey=jwtj8mp7rre8hfckd4yww2jj&sig=sig&locale=en-US&duration=120")

        programApi: (program) ->
          this.unblock()
          return Meteor.http.call("GET", "http://api.rovicorp.com/TVlistings/v9/listings/programdetails/#{program}/info?locale=en-US&include=Program,Credit,Image&apikey=jwtj8mp7rre8hfckd4yww2jj&sig=sig")