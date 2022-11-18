import 'package:flutter/material.dart';
import 'package:flutter_application/services/places_service.dart';

import '../models/place_search.dart';

class ApplicationBloc with ChangeNotifier {
  final placesService = PlacesService();
  List<PlaceSearch>? searchResults;

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }
}
