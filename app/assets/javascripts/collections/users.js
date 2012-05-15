//App.Controllers.Users = Backbone.Controller.extend({
//    routes: {
//        "users/:id":            "edit",
//        "":                         "index",
//        "new":                      "newDoc"
//    },
//    
//    edit: function(id) {
//        var doc = new User({ id: id });
//        doc.fetch({
//            success: function(model, resp) {
//                new App.Views.Edit({ model: doc });
//            },
//            error: function() {
//                new Error({ message: 'Could not find that user.' });
//                window.location.hash = '#';
//            }
//        });
//    },
//    
//    index: function() {
//        $.getJSON('/users', function(data) {
//            if(data) {
//                var users = _(data).map(function(i) { return new User(i); });
//                new App.Views.Index({ users: users });
//            } else {
//                new Error({ message: "Error loading users." });
//            }
//        });
//    },
//    
//    newDoc: function() {
//        new App.Views.Edit({ model: new User() });
//    }
//});


