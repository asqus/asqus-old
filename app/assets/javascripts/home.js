var locale;

function receiveLocation() {
  locale = google.loader.ClientLocation;
  if (!locale) {
    return;
  }
  $('#message').html('Finding representatives for '+ locale.address.city +'.');
  
  $.get('/reps/find_by_latlong', {lat: locale.latitude, long: locale.longitude}, receiveReps);
}


function receiveReps(data) {
  if (!locale) {
    return;
  }
  $('#message').html('Found your representatives for '+ locale.address.city + ':');
  var reps = $.parseJSON(data);
  var repContainer = $('#repContainer');
  console.log(data[0]);
  $.each(data, function(index, value) {
    repContainer.append($('<div class="rep_name">'+ value +'</div>'));
  });
}

