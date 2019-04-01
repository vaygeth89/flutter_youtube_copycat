import 'package:flutter/material.dart';
import 'package:reactive_movie_app/bloc/video_bloc.dart';
import 'package:reactive_movie_app/model/video.dart';
import 'package:reactive_movie_app/ui/video_screen.dart';

class MyHomePage extends StatefulWidget {
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoBloc videoBloc = VideoBloc();
  int _selectedIndex = 0;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    print("In getOrSearchVideos build method");
    return Scaffold(
      bottomNavigationBar: _getBottomNavigationBar(),
      appBar: _getAppBar(),
      body: Center(
        child: StreamBuilder(
          stream: videoBloc.videos,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print("in snapshot");
              return snapshot.data.length != 0
                  ? _getVideosListView(snapshot)
                  : Container(
                      child: Center(
                      //this is used whenever there 0 Todo
                      //in the data base
                      child: Text('No data'),
                    ));
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  void _onBottomNavigationBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Colors.grey[700]))),
      child: BottomNavigationBar(
        iconSize: 25,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.trending_up,
                color: Colors.grey,
              ),
              title: Text('Trending'),
              activeIcon: Icon(
                Icons.trending_up,
                color: Colors.white,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.subscriptions,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.subscriptions,
                color: Colors.white,
              ),
              title: Text('Subscriptions')),
          BottomNavigationBarItem(
              icon: Container(
                child: Stack(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    new Positioned(
                        left: 6.0,
                        bottom: 7.0,
                        child: new Stack(
                          children: <Widget>[
                            new Icon(Icons.brightness_1,
                                size: 20.0, color: Colors.red),
                            new Positioned(
                                bottom: 2.0,
                                left: 6.0,
                                child: new Center(
                                  child: new Text(
                                    '5',
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ],
                        ))
                  ],
                ),
              ),
              activeIcon: Stack(
                children: <Widget>[
                  Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  new Positioned(
                      left: 6.0,
                      bottom: 7.0,
                      child: new Stack(
                        children: <Widget>[
                          new Icon(Icons.brightness_1,
                              size: 20.0, color: Colors.red),
                          new Positioned(
                              bottom: 2.0,
                              left: 6.0,
                              child: new Center(
                                child: new Text(
                                  '5',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ],
                      ))
                ],
              ),
              title: Text('Inbox')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.folder,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.folder,
                color: Colors.white,
              ),
              title: Text('Library')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onBottomNavigationBarItemTapped,
      ),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Row(
        children: <Widget>[
          new IconButton(
            icon: new Image.asset('assets/youtube_logo.png'),
            tooltip: 'Refresh',
            onPressed: () {},
          ),
          Expanded(
            child: Text(
              'YCopycat',
              style: TextStyle(fontSize: 17),
            ),
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _getVideosListView(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, itemPosition) {
        Video video = snapshot.data[itemPosition];
        return Card(
          color: Colors.grey[850],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InkWell(onTap: () => _watchVideo(context,video.video),
                child: Container(
//                  decoration: BoxDecoration(
//                      image: DecorationImage(
//                          //fit: BoxFit.fill,
//                          image: NetworkImage(video.thumbnail))),

                  child: Image.network(video.thumbnail  ,fit: BoxFit.fitWidth,key: UniqueKey(),),
                ),
              ),
              ListTile(
                leading: new Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(video.channel.icon)))),
                title: Text(
                  video.title,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Wrap(
                  children: <Widget>[
                    Text('${video.channel.name} . ',
                        style: TextStyle(color: Colors.grey)),
                    Text('${video.views} views',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _watchVideo(BuildContext context,String videoURL) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoPage(videoURL: videoURL,)),
    );
  }
}
