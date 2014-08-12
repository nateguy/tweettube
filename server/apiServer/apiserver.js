

if (Meteor.isServer) {
    Meteor.methods({
        RoviApi: function () {
            this.unblock();
            return Meteor.http.call("GET", "http://api.rovicorp.com/TVlistings/v9/listings/gridschedule/20518/info?apikey=ayxxzenpvq37qpenazudm465&sig=sig&locale=en-US&duration=120");
          }

    });
}


// if (Meteor.isServer) {
//     Meteor.methods({
//         RoviApi2: function () {
//             this.unblock();
//             return Meteor.http.call("GET", "http://api.rovicorp.com/TVlistings/v9/listings/gridschedule/20519/info?apikey=ayxxzenpvq37qpenazudm465&sig=sig&locale=en-US&duration=120");
//         }
//     });
// }


// if (Meteor.isServer) {
//     Meteor.methods({
//         RoviApi3: function () {
//             this.unblock();
//             return Meteor.http.call("GET", "http://api.rovicorp.com/TVlistings/v9/listings/gridschedule/20520/info?apikey=ayxxzenpvq37qpenazudm465&sig=sig&locale=en-US&duration=120");
//         }
//     });
// }


// if (Meteor.isServer) {
//     Meteor.methods({
//         RoviApi4: function () {
//             this.unblock();
//             return Meteor.http.call("GET", "http://api.rovicorp.com/TVlistings/v9/listings/gridschedule/20521/info?apikey=ayxxzenpvq37qpenazudm465&sig=sig&locale=en-US&duration=120");
//         }
//     });
// }