/* 
 function initialize() {

  var input = document.getElementById('hospital_searchTextField');
  var autocomplete = new google.maps.places.Autocomplete(input);
  google.maps.event.addListener(autocomplete, 'place_changed', function () {
    var place = autocomplete.getPlace();
        //document.getElementById('addName').value = place.formatted_address;
        document.getElementById('hospital_addName').value = document.getElementById('hospital_searchTextField').value;
        document.getElementById('hospital_addLat').value = place.geometry.location.lat();
        document.getElementById('hospital_addLng').value = place.geometry.location.lng();
            //alert("This function is working!");
            //alert(place.name);
           // alert(place.address_components[0].long_name);

         });
}
google.maps.event.addDomListener(window, 'load', initialize); 
 */