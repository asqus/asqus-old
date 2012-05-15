// Poll Item View
// --------------

var PollView = Backbone.View.extend({
  tagName:  "li",

  // Cache the template function for a single item.
  template: JST['templates/poll_item'],

  // The DOM events specific to an item.
  events: {
    "click .publish"   : "publish",
    "dblclick .view"  : "edit",
    "click a.destroy" : "clear",
    "keypress .edit"  : "updateOnEnter",
    "blur .edit"      : "close"
  },

  // The PollView listens for changes to its model, re-rendering. Since there's
  // a one-to-one correspondence between a **Poll** and a **PollView** in this
  // app, we set a direct reference on the model for convenience.
  initialize: function() {
    this.model.bind('change', this.render, this);
    this.model.bind('destroy', this.remove, this);
  },

  // Re-render the titles of the poll item.
  render: function() {
    this.$el.html(this.template(this.model.toJSON()));
    this.$el.toggleClass('published', this.model.get('published'));
    this.input = this.$('.edit');
    return this;
  },

  publish: function() {
    this.model.publish();
  },

  // Switch this view into `"editing"` mode, displaying the input field.
  edit: function() {
    this.$el.addClass("editing");
    this.input.focus();
  },

  // Close the `"editing"` mode, saving changes to the poll.
  close: function() {
    var value = this.input.val();
    if (!value) this.clear();
    this.model.save({title: value});
    this.$el.removeClass("editing");
  },

  // If you hit `enter`, we're through editing the item.
  updateOnEnter: function(e) {
    if (e.keyCode == 13) this.close();
  },

  // Remove the item, destroy the model.
  clear: function() {
    this.model.clear();
  }

});


