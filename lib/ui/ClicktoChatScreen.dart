import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'roundedButton.dart';

class ClicktoChatScreen extends StatefulWidget {
  @override
  _ClicktoChatScreenState createState() => _ClicktoChatScreenState();
}

class _ClicktoChatScreenState extends State<ClicktoChatScreen> {

  TextEditingController phoneNumberContoller= new TextEditingController();
  String whatsappurl = "https://api.whatsapp.com/send?phone=" ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Click to Chat Whatsapp",
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          height: 300,
          width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Enter Whatsapp Number",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: phoneNumberContoller,
                  decoration: InputDecoration(
                      labelText: "Enter Number",
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: "Enter Number without country code",
                      hintStyle:
                          TextStyle(height: 1.5, fontWeight: FontWeight.w300),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      hoverColor: Colors.blue,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))),
                  keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(height: 20,),
              RoudedButton(
               
                onPressed: () async => await launch(
                  "https://api.whatsapp.com/send?phone=91${phoneNumberContoller.text}"
                  
                ),
                width: 200,
                height: 50,
                splashColor: Colors.blue,
                child: Text(
                  "Message",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
