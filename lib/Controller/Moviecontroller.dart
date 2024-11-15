import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:netflixappassignment/Networks/respo/movierespo.dart';
import 'package:netflixappassignment/Utils/utils.dart';

class Moviecontroller extends GetxController  {
  final movierespo = MovieRespo();
  var movies = <dynamic>[].obs;
  var searchResults = <dynamic>[].obs;
  var isLoading = false.obs;

  // fetch movies
  Future<void> fetchMovies() async {

    isLoading.value = true;
    try {
      final response = await movierespo.getmovielist();
      
      if (response is List<dynamic>) {
        movies.value = response;
      } else {
        // in any msg error
        Utils.snackbar("No Data Found", "Please try after Sometimes");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // in any msg error
      Utils.snackbar('Error', e.toString());
    }
    isLoading.value = false;
  }

  // search
  Future<void> searchMovies(String query) async {
    isLoading.value = true;
    try{
      final response = await movierespo.searrchmovies(query);

      if (response is List<dynamic>) {
        searchResults.value = response;
      } else {
        Utils.snackbar("No Data Found", "Please try after Sometimes");
      }
    }catch(e){
      Utils.snackbar('Error', e.toString());
    }
    isLoading.value = false;
  }
}
