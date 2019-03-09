import 'dart:async';

import 'package:reactive_movie_app/api_provider/video_api_provider.dart';
import 'package:reactive_movie_app/model/video.dart';

class VideoBloc {
  final videoProvider = VideoApiProvider();

  //broadcast streams allows for multiples subscribers/listeners
  //to the stream of data, so whenever the state of that stream of data
  final _videoController = StreamController<List<Video>>.broadcast();


  //Our stream getter method
  get videos => _videoController.stream;

  VideoBloc() {
    print("in bloc constructor");
    getVideos();
  }

  getVideos({String query}) async {
    //add event, events in reactive programming are list (or single) future data of specific type
    //for instance Future of Video/Videos
    //in this case Videos
    print("In getOrSearchVideos");
    _videoController.sink.add(await videoProvider.getOrSearchVideos(searchQuery: query));
  }

  // here we make sure to close the stream
  // whenever the caller widget lifecycle ended (disposed)
  // to prevent memory leak
  dispose() {
    _videoController.close();
  }
}