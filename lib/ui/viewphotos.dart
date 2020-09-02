import 'dart:io';
import 'dart:typed_data';
//import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';

//import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:flutter_share/flutter_share.dart';
//import 'package:esys_flutter_share/esys_flutter_share.dart';
//import 'package:share_extend/share_extend.dart';
//import 'package:share/share.dart';

class ViewPhotos extends StatefulWidget {
  final String imgPath;
  ViewPhotos(this.imgPath);
  @override
  _ViewPhotosState createState() => _ViewPhotosState();
}

class _ViewPhotosState extends State<ViewPhotos> {
  var filePath;

  var tempshare;
  var tempfilename;
  final LinearGradient backgroundGradient = new LinearGradient(
    colors: [
      Color(0x00000000),
      Color(0x00333333),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
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
                          Text("FileManager > Status of Whatsapp Downloader",
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

        Uri myUri = Uri.parse(widget.imgPath);
        File originalImageFile = new File.fromUri(myUri);
        Uint8List bytes;
        await originalImageFile.readAsBytes().then((value) {
          bytes = Uint8List.fromList(value);
          print('reading of bytes is completed');
        }).catchError((onError) {
          print('Exception Error while reading audio from path:' +
              onError.toString());
        });
        final result =
            await ImageGallerySaver.saveImage(Uint8List.fromList(bytes));
        //print("result is ${result}");
        tempshare = result;

        _onLoading(false,
            "If Image not available in gallary\n\nYou can find all images at");
      }, "Save", Colors.black, Colors.white, true),
      new FabMiniMenuItem.withText(
          new Icon(Icons.share), Colors.black, 4.0, "Button menu", () async {
        File originalImageFile = File(widget.imgPath);
        String originalfilename = originalImageFile.path;
        // print("Origial file name is  $originalfilename");
        // final String dir = (await getExternalStorageDirectory()).parent.parent.parent.parent.path;
        // final String path = "$dir/story_save/$originalfilename";
        // print("Origial file name  path is  $path");
        // ShareExtend.share(path, "file");
        // final ByteData bbytes = await rootBundle.load(image);
        // Share.file("title", "sa", bbytes.buffer.asUint8List(), "image/jpg");

        await FlutterShare.shareFile(
          
            title: 'Status of Whatsapp Downloader app', filePath: originalfilename);
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

final tranformationcontroller = TransformationController();
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.indigo,
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: widget.imgPath,
                child: InteractiveViewer(
                  transformationController: tranformationcontroller,
                  onInteractionEnd: (detailes){
                      setState(() {
                        tranformationcontroller.toScene(Offset.zero);
                      });
                  },
                  boundaryMargin: EdgeInsets.all(5.0),
                  maxScale: 5.0,
                  child: Image.file(
                 File(widget.imgPath),
                  fit: BoxFit.cover,
                ),

                // child: Image.file(
                //   File(widget.imgPath),
                //   fit: BoxFit.cover,
                ),
              ),
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
    );
  }
}
