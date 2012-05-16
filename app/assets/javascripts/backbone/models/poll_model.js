  // Poll Model
  // ----------

  var Poll = Backbone.Model.extend({

    // Default attributes for the poll.
    defaults: function() {
      return {
        title: "[Poll title]",
        published: false,
      };
    },

    // Ensure that each poll created has defaults.
    initialize: function() {
      if (!this.get("title")) {
        this.set({"title": this.defaults.title});
      }
      if (!this.get("published")) {
        this.set({"published": this.defaults.title});
      }
    },

    publish: function() {
      this.save({published: true});
    },

    // Remove this Poll *localStorage* and delete its view.
    clear: function() {
      this.destroy();
    }

  });

