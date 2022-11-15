/*
Here we write a service so that we can get json from google places api and convert to dart object as defined in our model.
*/
import 'package:flutter_application/models/place_search.dart';
import 'package:http/http.dart' as http; //for http requests aka the google api
import 'dart:convert'
    as convert; //to convert between data representations aka json to dart object.

class PlacesService {
  final key = 'AIzaSyCjmZuiimm7QZSJmxvfTBJBSblMeHyG6UQ';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&inputtype=textquery&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response
        .body); //jsonDecode parses string and returns resulting json object

    //we want results as a list - we grab the predictions object, and then we get a list of all of the objects within it, aka, the suggestions.
    var jsonResults = json['predictions'] as List;

    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}
