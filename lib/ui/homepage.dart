import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:story_save/ui/ClicktoChatScreen.dart'; 
import 'package:story_save/ui/dashboard.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Status",
                style: TextStyle(
                    fontSize: 18,
                    wordSpacing: 3,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: " Saver",
                style: TextStyle(
                    fontSize: 18,
                    wordSpacing: 3,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue))
          ])),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          brightness: Brightness.light,
          actions: [
            IconButton(
              icon: Icon(
                Icons.live_help,
                color: Colors.blue,
              ),
              onPressed: () {
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
                                      "How To Use?",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.all(10.0),
                                    // ),
                                    Text(
                                        "1) check the Desired Status/Story on Whatspp",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        "2) Come Back to App,Click o any Image or Video to view",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        "3) Click the Save Button...\n The Image/Video is Intantly saved to Your Gallery ",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        "4) Click the Share Button...\n The Image/Video is Intantly share to Your friends",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black)),

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
              },
            ),

             IconButton(icon: Icon(
              FlutterIcons.ios_chatbubbles_ion,
              size: 28,
              color:Colors.blue
            ), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ClicktoChatScreen()));
            })
          ],
          bottom: TabBar(
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.blue,
              labelColor: Colors.black,
              tabs: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'IMAGES',
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'VIDEOS',
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Quotes',
                  ),
                ),
              ]),
        ),
        body: Dashboard(),
      ),
    );
  }
}
