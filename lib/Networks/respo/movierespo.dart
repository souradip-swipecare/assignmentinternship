import 'package:netflixappassignment/Networks/apicall.dart';
import 'package:netflixappassignment/Networks/url.dart';

class MovieRespo {
  final _apiservice = Networkapi();
  Future<dynamic> getmovielist() async {
    dynamic response = _apiservice.getapi(Apiurl.searchall);
    return response;
  }

  Future<dynamic> searrchmovies(String url) async {
    dynamic response = _apiservice.getapi(url);
    return response;
  }
}
