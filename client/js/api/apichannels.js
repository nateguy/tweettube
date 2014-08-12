

Template.apiChannel1.helpers({
  showName1: function () {
    if (Meteor.isClient) {
      Meteor.call("RoviApi", function(error, results) {
        $(".show1").html(results.data.GridScheduleResult.GridChannels[1].DisplayName);
      });
    }
  }
});


Template.apiChannel2.helpers({
  showName2: function () {
    if (Meteor.isClient) {
      Meteor.call("RoviApi", function(error, results) {
        $(".show2").html(results.data.GridScheduleResult.GridChannels[1].DisplayName);
      });
    }
  }
});

Template.apiChannel3.helpers({
  showName3: function () {
    if (Meteor.isClient) {
      Meteor.call("RoviApi", function(error, results) {
        $(".show3").html(results.data.GridScheduleResult.GridChannels[2].DisplayName);
      });
    }
  }
});

Template.apiChannel4.helpers({
  showName4: function () {
    if (Meteor.isClient) {
      Meteor.call("RoviApi", function(error, results) {
        $(".show4").html(results.data.GridScheduleResult.GridChannels[3].DisplayName);
      });
    }
  }
});





