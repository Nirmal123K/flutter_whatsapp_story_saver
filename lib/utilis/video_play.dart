import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:story_save/utilis/video_controller.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:flutter_share/flutter_share.dart';

class PlayStatus extends StatefulWidget {
  final String videoFile;
  PlayStatus(this.videoFile);
  @override
  _PlayStatusState createState() => new _PlayStatusState();
}

class _PlayStatusState extends State<PlayStatus> {
  @override
  void initState() {
    super.initState();
    print('Video file you are looking for:' + widget.videoFile);
  }

  void dispose() {
    super.dispose();
  }

  void _onLoading(bool t, String str) {
    if (t) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator()),
                ),
              ],
            );
          });
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SimpleDialog(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Great, Saved in Gallary",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text(str,
                              style: TextStyle(
                                fontSize: 16.0,
                              )),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text("FileManager > story_save",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.grey)),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          MaterialButton(
                            child: Text("Close"),
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _fabMiniMenuItemList = [
      new FabMiniMenuItem.withText(
          new Icon(Icons.sd_storage), Colors.black, 4.0, "Button menu",
          () async {
        _onLoading(true, "");

        File originalVideoFile = File(widget.videoFile);
        Directory directory = await getExternalStorageDirectory();
        String temppath = directory.parent.parent.parent.parent.path;
        //  print("Directory is ${directory}");

        //print("Path is ${path}");

        String originalfilename =
            originalVideoFile.path.split("/").last.toString();
        // String curDate = DateTime.now().toString();
        String newFileName = "$temppath/story_save/$originalfilename";
        //   print("newFileName is ${newFileName}");
        await originalVideoFile.copy(newFileName);

        _onLoading(false,
            "If Image not available in gallary\n\nYou can find all images at");
      }, "Save", Colors.black, Colors.white, true),
      new FabMiniMenuItem.withText(
          new Icon(Icons.share), Colors.black, 4.0, "Button menu", () async {
        File originalVideoFile = File(widget.videoFile);
        String originalfilename = originalVideoFile.path;

        await FlutterShare.shareFile(
            title: 'Story Saver app', filePath: originalfilename);
      }, "Share", Colors.black, Colors.white, true),

      // new FabMiniMenuItem.withText(new Icon(Icons.wallpaper), Colors.teal, 4.0,
      //     "Button menu", () {}, "Set As", Colors.black, Colors.white, true),
      // new FabMiniMenuItem.withText(
      //     new Icon(Icons.delete_outline),
      //     Colors.teal,
      //     4.0,
      //     "Button menu",
      //     () {},
      //     "Delete",
      //     Colors.black,
      //     Colors.white,
      //     true),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            StatusVideo(
              videoPlayerController:
                  VideoPlayerController.file(File(widget.videoFile)),
              looping: true,
              videoSrc: widget.videoFile,
            ),
            new FabDialer(
                _fabMiniMenuItemList,
                Colors.white,
                new Icon(
                  Icons.add,
                  color: Colors.black,
                )),
          ],
        ),
      ),
      // floatingActionButton: new FloatingActionButton(
      //     backgroundColor: Colors.white,
      //     child: Icon(Icons.save,color: Colors.black,),
      //     onPressed: () async {
      //       _onLoading(true, "");

      //       File originalVideoFile = File(widget.videoFile);
      //       Directory directory = await getExternalStorageDirectory();
      //       String temppath = directory.parent.parent.parent.parent.path;
      //       //  print("Directory is ${directory}");

      //       //print("Path is ${path}");

      //       String originalfilename =
      //           originalVideoFile.path.split("/").last.toString();
      //       // String curDate = DateTime.now().toString();
      //       String newFileName = "$temppath/story_save/$originalfilename";
      //       //   print("newFileName is ${newFileName}");
      //       await originalVideoFile.copy(newFileName);

      //       _onLoading(false,
      //           "If Video not available in gallary\n\nYou can find all videos at");
      //     }),
    );
  }
}
