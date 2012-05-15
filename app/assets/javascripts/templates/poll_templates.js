// Poll templates

var t_poll_item = '\
  <div class="view">\
  <input class="publish <%= published ? \'poll_published\' : \'poll_unpublished\' %>" type="button" value="Publish" />\
  <label><%= title %></label>\
  <a class="destroy"></a>\
  </div>\
  <input class="edit" type="text" value="<%= title %>" />\
';

var t_poll_stats = '\
  <div class="poll-count"><b><%= unpublished %></b> <%= unpublished == 1 ? \'item\' : \'items\' %> left</div>\
';

