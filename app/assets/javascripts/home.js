var locale;

function receiveLocation() {
  locale = google.loader.ClientLocation;
  $('#message').html('Finding representatives for '+ locale.address.city +'.');
  
  $.get('/reps/find_by_latlong', {lat: locale.latitude, long: locale.longitude}, receiveReps);
}


function receiveReps(data) {
  $('#message').html('Found your representatives for '+ locale.address.city + ':');
  var reps = $.parseJSON(data);
  var repContainer = $('#repContainer');
  console.log(data[0]);
  $.each(data, function(index, value) {
    repContainer.append($('<div class="rep_name">'+ value +'</div>'));
  });
}

