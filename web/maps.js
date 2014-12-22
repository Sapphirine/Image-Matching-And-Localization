/*
* FILE: maps.js
* AUTHOR: Chris Stathis
* DESCRIPTION: Google Maps StreetView API call generator. Interpolates 
*             latitude, longitude points along streets in New York City
*             and writes them to URLs to be invoked as StreetView image
*             requests. 
* 
* Copyright 2014 Chris Stathis
* 
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*    http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
var c = 0;

function initialize() {
    var mapOptions = {
        zoom: 17,
        center: new google.maps.LatLng(40.808672, -73.9621319)
    };
    // Initialize Google Maps API
    var map = new google.maps.Map(document.getElementById('map-canvas'),
        mapOptions);
    
    // Invoke when the HTML page is done loading
    google.maps.event.addListener(map, 'idle', function() {
        
        // 120th and amsterdam to 114th and amsterdam
        // facing campus
        makePointList(map, new google.maps.LatLng(40.8089702, -73.9599765), new google.maps.LatLng(40.8062275,-73.9618058), 303, 4);
        // facing away from campus
        makePointList(map, new google.maps.LatLng(40.8089702, -73.9599765), new google.maps.LatLng(40.8062275,-73.9618058), 123, 4);
        
        // 120th and broadway to 114th and broadway
        // facing campus
        makePointList(map, new google.maps.LatLng(40.8101582, -73.9616928), new google.maps.LatLng(40.8065319,-73.9646088), 123, 4);
        // facing away from campus
        makePointList(map, new google.maps.LatLng(40.8101582, -73.9616928), new google.maps.LatLng(40.8065319,-73.9646088), 303, 4);
    
        // long path down columbus ave
        makePointList(map, new google.maps.LatLng(40.7998693, -73.9623135), new google.maps.LatLng(40.786447, -73.972088), 123, 4);
        makePointList(map, new google.maps.LatLng(40.7998693, -73.9623135), new google.maps.LatLng(40.786447, -73.972088), 303, 4);
        
    })
}

function makePointList(map, latLngFrom, latLngTo, hdg, fractionStep) {
    for(i = 0; i < 100; i = i+fractionStep) {
        ptBetween = mercatorInterpolate(map, latLngFrom, latLngTo, i/100.0);
        var marker = new google.maps.Marker({
            position: ptBetween,
            map: map
        });
   
        /* This can be used to manually compute the headings perpendicular
           to a street.

        var dLon = (latLngTo.lng() - latLngFrom.lng()) * Math.PI / 180.0;
        var brng = Math.atan2(Math.sin(dLon) * Math.cos(latLngTo.lat() * Math.PI / 180.0),
                            Math.cos(latLngFrom.lat() * Math.PI / 180.0) * Math.sin(latLngTo.lat() * Math.PI / 180.0) -
                            Math.sin(latLngFrom.lat() * Math.PI / 180.0) * Math.cos(latLngTo.lat() * Math.PI / 180.0) * 
                            Math.cos(dLon)) * 180.0 / Math.PI;
        console.log(brng);
        var hdgs = [brng + 90.0, brng - 90.0];
        for (hdg in hdgs) {
            document.write(ptbetween.lat() + "," + ptbetween.lng() + "," + hdg + "," + "https://maps.googleapis.com/maps/api/streetview?size=640x640&location=" + ptbetween.lat() + "," + ptbetween.lng() + "&heading=" + hdg + "<br>");
            console.log(ptbetween);
        }
        */
    
        // Write out the URL
        document.write(c + " " + ptBetween.lat() + " " + ptBetween.lng() + " " + hdg + " " + "https://maps.googleapis.com/maps/api/streetview?size=640x640&location=" + ptBetween.lat() + "," + ptBetween.lng() + "&heading=" + hdg + "?key=AIzaSyACmaWMJLSMhb6vLBaaBDTGgLgSXDYkvrY" + "<br>");
        console.log(ptBetween);
        c++;
    }
}

function mercatorInterpolate( map, latLngFrom, latLngTo, fraction ) {

    // Get projected points
    var projection = map.getProjection();
    var pointFrom = projection.fromLatLngToPoint( latLngFrom );
    var pointTo = projection.fromLatLngToPoint( latLngTo );
    
    // Adjust for lines that cross the 180 meridian
    if( Math.abs( pointTo.x - pointFrom.x ) > 128 ) {
        if( pointTo.x > pointFrom.x )
            pointTo.x -= 256;
        else
            pointTo.x += 256;
    }

    // Calculate point between
    var x = pointFrom.x + ( pointTo.x - pointFrom.x ) * fraction;
    var y = pointFrom.y + ( pointTo.y - pointFrom.y ) * fraction;
    var pointBetween = new google.maps.Point( x, y );

    // Project back to lat/lng
    var latLngBetween = projection.fromPointToLatLng( pointBetween );
    return latLngBetween;
}
