//= require_self
//= require_tree ./templates
//= require_tree ./models
//= require_tree ./views
//= require_tree ./routers

window.AsqUs = {
  Models: {},
  Collections: {},
  Routers: {},
  Views: {},
};


/*
$(function(){

  // Create our global collection of **Polls**.
  var Polls = new PollList;


  // The Application
  // ---------------

  // Our overall **AppView** is the top-level piece of UI.
  var AppView = Backbone.View.extend({

    // Instead of generating a new element, bind to the existing skeleton of
    // the App already present in the HTML.
    el: $("#pollContainer"),

    // Our template for the line of statistics at the bottom of the app.
    statsTemplate: _.template(t_poll_stats),

    // Delegated events for creating new items, and clearing completed ones.
    events: {
      "keypress #new-poll":  "createOnEnter",
      "click #publish-all": "toggleAllPublished"
    },

    // At initialization we bind to the relevant events on the `Polls`
    // collection, when items are added or changed. Kick things off by
    // loading any preexisting polls that might be saved in *localStorage*.
    initialize: function() {
      this.input = this.$("#new-poll");
      this.allCheckbox = this.$("#publish-all")[0];

      Polls.bind('add', this.addOne, this);
      Polls.bind('reset', this.addAll, this);
      Polls.bind('all', this.render, this);

      this.footer = this.$('.footer');
      this.main = $('#main');

      Polls.fetch();
    },

    // Re-rendering the App just means refreshing the statistics -- the rest
    // of the app doesn't change.
    render: function() {
      var published = Polls.published().length;
      var unpublished = Polls.unpublished().length;

      if (Polls.length) {
        this.main.show();
        this.footer.show();
        this.footer.html(this.statsTemplate({published: published, unpublished: unpublished}));
      } else {
        this.main.hide();
        this.footer.hide();
      }

      this.allCheckbox.checked = !unpublished;
    },

    // Add a single poll to the list by creating a view for it, and
    // appending its element to the `<ul>`.
    addOne: function(poll) {
      var view = new PollView({model: poll});
      this.$("#poll-list").append(view.render().el);
    },

    // Add all items in the **Polls** collection at once.
    addAll: function() {
      Polls.each(this.addOne);
    },

    // If you hit return in the main input field, create new **Poll** model,
    // persisting it to *localStorage*.
    createOnEnter: function(e) {
      if (e.keyCode != 13) return;
      if (!this.input.val()) return;

      Polls.create({title: this.input.val()});
      this.input.val('');
    },

//    // Clear all published polls, destroying their models.
//    clearCompleted: function() {
//      _.each(Polls.done(), function(poll){ poll.clear(); });
//      return false;
//    },

    toggleAllPublished: function () {
      var published = this.allCheckbox.checked;
      Polls.each(function (poll) { poll.save({'published': published}); });
    }

  });


  // Finally, we kick things off by creating the **App**.
  var App = new AppView;

}); 
*/
