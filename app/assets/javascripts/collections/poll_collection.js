// Poll Collection
// ---------------

// The collection of polls is backed by *localStorage* instead of a remote
// server.
var PollList = Backbone.Collection.extend({

  // Reference to this collection's model.
  model: Poll,

  // Save all of the polls under the "polls" namespace.
  localStorage: new Store("polls-backbone"),

  // Filter down the list of all poll items that are published.
  published: function() {
    return this.filter(function(poll){ return poll.get('published'); });
  },

  // Filter down the list to only unpublished polls.
  unpublished: function() {
    return this.without.apply(this, this.published());
  },

  // We keep the Polls in sequential order, despite being saved by unordered
  // GUID in the database. This generates the next order number for new items.
  //nextOrder: function() {
  //  if (!this.length) return 1;
  //  return this.last().get('order') + 1;
  //},

  // Polls are sorted by their original insertion order.
  //comparator: function(poll) {
  //  return poll.get('order');
  //}

});

