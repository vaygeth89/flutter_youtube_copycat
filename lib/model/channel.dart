
class Channel{

  int id;
  String name;
  String icon;

  Channel({this.id,this.name,this.icon});

  factory Channel.fromJson(Map<String, dynamic> data) => new Channel(
    id: data['id'],
    name: data['name'],
    icon: data['icon']
  );



}