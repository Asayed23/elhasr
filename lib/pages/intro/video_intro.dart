import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../category/view/category.dart';

class ViedoIntro extends StatefulWidget {
  @override
  _ViedoIntroState createState() => _ViedoIntroState();
}

class _ViedoIntroState extends State<ViedoIntro> {
  bool _skipViedoIntro = false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/intro.mp4")
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VideoPlayer(_controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                    onPressed: () {
                      Get.to(CategoryPage());
                    },
                    child: Text("Skip", style: TextStyle(color: Colors.white)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: CheckboxListTile(
                    title: Text("Don't show again"),
                    value: _skipViedoIntro,
                    onChanged: (value) {
                      setState(() {
                        _skipViedoIntro = value!;
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
