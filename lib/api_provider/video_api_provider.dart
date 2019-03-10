import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reactive_movie_app/api_provider/api_base.dart';
import 'package:reactive_movie_app/model/video.dart';

class VideoApiProvider extends BaseApi{

  final urlPath = 'feeds/';


  Future<List<Video>> getOrSearchVideos({String searchQuery}) async{
    print("In getOrSearchVideos()");
    var response;
    if(searchQuery !=null){
      response = await http.get('${ baseURL+ urlPath}?search=$searchQuery');
    }
    else {
      response = await http.get('${baseURL + urlPath}');
    }

    if(response.statusCode  == 200){
      Iterable list = json.decode(response.body);
      print("Boddy ${response.body}");
      return list.map((video)=> Video.fromJson(video)).toList();
    }
    else{
      // If that response was not OK, throw an error.
      List<Video> emptyVideoList = List();
      return emptyVideoList;
    }

  }

}