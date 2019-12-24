import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momapp/data.dart';
import 'package:momapp/model/content.dart';
import '../ContentDetails.dart';
import '../HomePage.dart';
import '../InAppPurchasePage.dart';
import '../mainscreen.dart';
import '../paid_card.dart';

class teest extends StatefulWidget {
  teest({this.contentDetails});
  final Content contentDetails;

  @override
  _teestState createState() => _teestState();
}

class _teestState extends State<teest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withBlue(16),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: CategorySlider(),
        ));
  }
}




class SuggestionItemMainPage extends StatefulWidget {
  SuggestionItemMainPage({this.contentDetails});
  final Content contentDetails;

  @override
  _SuggestionItemMainPageState createState() => _SuggestionItemMainPageState();
}

class _SuggestionItemMainPageState extends State<SuggestionItemMainPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: GestureDetector(
          onTap: () {
            content = [];
            itemler = [];
            lastRead = widget.contentDetails.contentName;
            contentDesc = widget.contentDetails.contentDescription;
            for (var i = 0; i < widget.contentDetails.contentText.length; i++) {
              content.add(
                Text(widget.contentDetails.contentText[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF37464D),
                      fontSize: 22.0,
                      fontFamily: 'GalanoMedium',
                      fontWeight: FontWeight.w300,
                    )),
              );
              itemler.add(i);
            }
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ));
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    spreadRadius: 7.0,),],
              color: Colors.white10,
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: NetworkImage("https://i.hizliresim.com/P7jZPd.png"),
              ),
            ),
          ),
        ),
      ),
    );}
}
