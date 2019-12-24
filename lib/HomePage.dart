import 'package:flutter/material.dart';
import 'package:momapp/model/movie.dart';
import 'package:momapp/popular_movies_main_page.dart';
import 'package:momapp/widget/dart.dart';
import 'ContentDetails.dart';
import 'InAppPurchasePage.dart';
import 'data.dart';
import 'package:momapp/blocs/content_list_bloc.dart';
import 'package:momapp/model/content.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:momapp/blocs/app_bloc.dart';

import 'mainscreen.dart';
//import 'package:momapp/FavWidgetClass.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  AppBloc appBloc;
  ContentListBloc contentListBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(

              color: Color(0xFFee3f46),

          ),
          child: Center(
            child: Column(

                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 0.0),
                    child: Text("FRIENDLY FIRE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontFamily: "Chewy"
                            , decoration: TextDecoration.none)),
                  ),
                  const SizedBox(height: 3),
                  Expanded(
                    flex: 3,
                    child: Container( width: 380, height: 250,

                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FlatButton(

                          onPressed: () {

                            randomuser = [];

                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => teest()),
                          );},
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(16.0),
                              side: BorderSide(color: Colors.transparent)
                          ),                  color: Colors.white,
                          padding: const EdgeInsets.only( right: 30, left: 30, top: 30, bottom: 0.0),

                          child: Column( children: <Widget>[

                            Image.asset('assets/Button.png', width: 100, height: 100,),
                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Text("PLAY GAME",
                                style: TextStyle( fontSize: 33, color: Color(0xFFC22F22),
                                    fontFamily: "Lilita", fontWeight: FontWeight.w700 ),),
                            ),

                          ],),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(

                          color: Color(0xFFee3f46),

                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 30.0, top: 25, bottom: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                              ],
                            ),
                          ),
                CategorySlider(
                  categoryName: 'EXPLORE',
                ),
              ],
            ),
          ),

        ),
    ]

    ),
    ),
      )
    ); 
  }
}



class CategorySlider extends StatelessWidget {
  final String categoryName;

  const CategorySlider({
    Key key,
    @required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFFF3F4F8)),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 8.0, bottom: 15.0),
                    child: Container(
                      child: Text('asdasd',
                          style: TextStyle(
                              fontSize:20.0,
                              fontFamily: "Lilita",
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFee3f46),)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {


                      randomuser = [];

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => teest(),
                          ));
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          'See All',
                          style: TextStyle(
                              color: Colors.grey, fontFamily: 'GalanoBold', fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
              child: Container(
                height: 260,
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('contents')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(child: CircularProgressIndicator())
                        : _buildDealsList(context, snapshot.data.documents);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainPageHeader extends StatelessWidget {
  final String bookName;
  final String desc;

  MainPageHeader({this.bookName, this.desc});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('En üst kısma tıklandı');
        content = [];
        itemler = [];
        lastRead = userDocument["contentName"];

        for (var i = 0; i < userDocument["contentText"].length; i++) {
          content.add(
            Text(userDocument["contentText"][i],
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
/*
        questionBank = [];
        for (var i = 0; i < userDocument["contentQuestions"].length; i++) {
          questionBank.add(
            Question(userDocument["contentQuestions"][i],
                userDocument["contentAnswers"][i]),
          );
        }
*/
        content = content.reversed.toList();
        //   questionBank = questionBank.reversed.toList();

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => teest(),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Card(
                    elevation: 2,
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFFF3F4F8)),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                          image: AssetImage('assets/mainpage.jpg'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(3.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  'Popular',
                                  style: TextStyle(
                                      fontFamily: 'GalanoMedium',
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFF2c3e50),
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Container(
                                        width: 315,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              bookName,
                                              style: TextStyle(
                                                  fontFamily: 'GalanoBold',
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                            Text(
                                              desc,
                                              style: TextStyle(
                                                  fontFamily: 'GalanoMedium',
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
              child: GestureDetector(
                onTap: () {


                },
                child: Card(
                  elevation: 2,
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFF3F4F8)),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 15.0, bottom: 15.0),
                              child: Text('Recent Books',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "GalanoBold",
                                    color: Color(0xFF2B3D50),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 0.0),
                        child: Container(
                          height: 260,
                          child: StreamBuilder(
                            stream: Firestore.instance
                                .collection('contents')
                                .snapshots(),
                            builder: (context, snapshot) {
                              return !snapshot.hasData
                                  ? Center(child: CircularProgressIndicator())
                                  : _buildDealsList(
                                      context, snapshot.data.documents);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDealsList(BuildContext context, List<DocumentSnapshot> snapshots) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return SuggestionItemMainPage(
            contentDetails: Content.fromSnapshot(snapshots[index]));
      });
}

class SuggestionItemMainPage extends StatefulWidget {
  SuggestionItemMainPage({this.contentDetails});
  final Content contentDetails;

  @override
  _SuggestionItemMainPageState createState() => _SuggestionItemMainPageState();
}

class _SuggestionItemMainPageState extends State<SuggestionItemMainPage> {
  var paddingControl = 5.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
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
                    fontSize: 25.0,
                    fontFamily: 'GalanoMedium',
                    fontWeight: FontWeight.w300,

                  )),
            );
            itemler.add(i);
          }



          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ));

        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 190,
                width: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://i.hizliresim.com/P7jZPd.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(paddingControl),
                    bottomRight: Radius.circular(paddingControl),
                  ),
                ),
                width: 150,
                height: 60,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8.0, right: 8.0),
                            
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
