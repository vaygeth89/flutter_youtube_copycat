import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String videoURL;

  VideoPage({this.videoURL});

  createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _controller;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    print("In getOrSearchVideos build method");
    print(widget.videoURL);
    playVideo();
    _controller.play();
    return Scaffold(
        body: Container(child: Center(child: _controller.value.initialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child:  VideoPlayer(_controller),
        )
            : Container(child: Center(child: CircularProgressIndicator(),),),
            ))
    );
  }

  @override
  void deactivate() {
    _controller.setVolume(0.0);
    _controller.removeListener(listener);
    super.deactivate();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void playVideo() {
    if (_controller == null) {
      _controller = VideoPlayerController.network(
          'https:\/\/r4---sn-vgqs7nlz.googlevideo.com\/videoplayback?sparams=dur%2Cei%2Cid%2Cip%2Cipbits%2Citag%2Clmt%2Cmime%2Cmm%2Cmn%2Cms%2Cmv%2Cpl%2Cratebypass%2Crequiressl%2Csource%2Cexpire&mn=sn-vgqs7nlz%2Csn-t0a7ln7d&mm=31%2C26&txp=5431432&ms=au%2Conr&ratebypass=yes&ipbits=0&pl=19&mv=u&mt=1552281773&mime=video%2Fmp4&expire=1552303907&signature=74C9A6D3ED97A3E3E41BB2E1C06D3FD9058C4E4E.7C9E9051FB4D2301151BAE2D443546A08985303A&key=yt6&ei=w_KFXJCOH5Gf8wT26b6QBA&ip=34.224.98.105&requiressl=yes&lmt=1541507685309049&itag=22&id=o-ALD2Zal_Jrg5RrMhFizkXhOEI8CbxBhGP4ZOaOT4mgSs&fvip=4&dur=153.135&source=youtube')
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
      _controller.play();
    } else {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.initialize();
        _controller.play();
      }
    }
  }
}
