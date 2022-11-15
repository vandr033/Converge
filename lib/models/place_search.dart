/*
In this model we define how to convert json string to dart object with our desired info.
*/

class PlaceSearch {
  //these are the fields we're interested in from the json string.
  final String description;
  final String placeId;

  PlaceSearch({required this.description, required this.placeId}); //constructor

  //factory constructor so that we can pass in json string and easily convert to dart object. 
  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
    return PlaceSearch(//return PlaceSearch dart object - map to json properties
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}
