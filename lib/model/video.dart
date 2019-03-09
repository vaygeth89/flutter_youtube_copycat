import 'package:intl/intl.dart';
import 'package:reactive_movie_app/model/channel.dart';

class Video{

  int id;
  DateTime releasedOn;
  String title;
  String thumbnail;
  String description;
  String video;
  int views;
  Channel channel;

  Video({this.id,this.releasedOn,this.title,this.thumbnail,this.description,this.video,this.views,this.channel});

  factory Video.fromJson(Map<String,dynamic> data) => new Video(
    id: data['id'],
    releasedOn: Video.setReleasedOnDatefromString(data['released_on']),
    title: data['title'],
    thumbnail: data['thumbnail'],
    description: data['description'],
    video: data['video'],
    views: data['views'],
    channel: Channel.fromJson(data['channel'])
  );

  static DateTime setReleasedOnDatefromString(String date){
    print(date);
    return DateTime.now();
  }

  String getFormattedReleaseDate({String formatType}) {
    DateFormat format;
    if (formatType != null ) {
      format = new DateFormat(formatType);
    } else {
      format = new DateFormat("MMM-dd");
    }
    return format.format(this.releasedOn);
  }


}