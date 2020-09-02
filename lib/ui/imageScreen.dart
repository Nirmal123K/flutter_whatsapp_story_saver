import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:story_save/ui/viewphotos.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

final Directory _photoDir =
    new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory("${_photoDir.path}").existsSync()) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Install WhatsApp\n",
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            "Your Friend's Status Will Be Available Here",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );
    } else {
      var imageList = _photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".jpg"))
          .toList(growable: false);
      if (imageList.length > 0) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: AnimationLimiter(
            child: StaggeredGridView.countBuilder(
              itemCount: imageList.length,
              crossAxisCount: 4,
              itemBuilder: (context, index) {
                String imgPath = imageList[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 300),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Material(
                        elevation: 8.0,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          ViewPhotos(imgPath)));
                            },
                            child: Hero(
                                tag: imgPath,
                                child: Image.file(File(imgPath),
                                    fit: BoxFit.cover))),
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (i) =>
                  StaggeredTile.count(2, i.isEven ? 2 : 2),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: new Container(
              padding: EdgeInsets.only(bottom: 60.0),
              child: Text(
                "Sorry,No Image Found",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        );
      }
    }
  }
}
