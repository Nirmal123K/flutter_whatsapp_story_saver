import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class QuotestextScreen extends StatefulWidget {
  @override
  _QuotestextScreenState createState() => _QuotestextScreenState();
}

class _QuotestextScreenState extends State<QuotestextScreen> {
  String url = 'https://type.fit/api/quotes';
  var responce;
  final RefreshController _refreshController = RefreshController();

  // ignore: missing_return
  Future<List<Quotes>> makeReq() async {
    try {
      responce = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

      var body = json.decode(responce.body);
      List<Quotes> data = [];
      for (var i in body) {
        Quotes quote = Quotes(i["text"], i["author"]);

        data.add(quote);
      }
      return data;
    } catch (e) {
      print("Network error!!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: makeReq(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return SpinKitRipple(
                  //shape: BoxShape.circle,
                  size: 100,
                  duration: Duration(seconds: 1),
                  color: Colors.blue,
                );
              } else {
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  header: null,
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 1));
                    _refreshController.refreshCompleted();
                  },
                  child: new ListView.builder(
                      itemCount:
                          snapshot.data == null ? 0 : snapshot.data.length,
                      itemBuilder: (BuildContext context, i) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    '"' + '${snapshot.data[i].text}' + '"',
                                    style: TextStyle(
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '-- ${snapshot.data[i].author}',
                                      style: TextStyle(
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          iconSize: 22.0,
                                          icon: Icon(Icons.content_copy),
                                          color: Colors.green,
                                          onPressed: () {
                                            FlutterClipboard.copy('"' +
                                                    '${snapshot.data[i].text}' +
                                                    '"' +
                                                    '--' +
                                                    '${snapshot.data[i].author}')
                                                .then((result) {
                                              final snackBar = SnackBar(
                                                content:
                                                    Text('Copied to Clipboard'),
                                              );
                                              Scaffold.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                          }),
                                      IconButton(
                                          iconSize: 22.0,
                                          icon: Icon(Icons.share),
                                          color: Colors.green,
                                          onPressed: () {
                                            Share.share(
                                                "${snapshot.data[i].text} " +
                                                    '\n\n' +
                                                    'By ${snapshot.data[i].author}');
                                          }),
                                    ],
                                  ))
                                ]),
                          ),
                        );
                      }),
                );
              }
            }),
      ),
    );
  }
}

class Quotes {
  final String text;
  final String author;

  Quotes(this.text, this.author);
}
