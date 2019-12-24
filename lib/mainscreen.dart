import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:momapp/addplayer.dart';
import 'package:momapp/blocs/bloc_provider.dart';
import 'package:momapp/data.dart' as prefix0;
import 'package:momapp/model/content.dart';
import 'package:momapp/paidcard.dart';

import 'bestGameComponent.dart';
import 'blocs/app_bloc.dart';
import 'blocs/content_list_bloc.dart';
import 'data.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: Color(0xFFee3f46),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  height: 350,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:1),

                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) => Card(

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      margin: EdgeInsets.only(
                        right: 15,
                        top: 50,
                        left: 15,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        child: Center(
                          child: Text('ASDASD'),
                        ),
                      ),
                    ),
                  ),

              ),
              Container(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 350,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45))),
                  child: new Wrap(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: <Widget>[
                          Text('ASDASDSAD',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 30, fontFamily: 'Lilita',
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.person_outline,
                                  size: 23,
                                ),
                                Text('2-4 Person',
                                    style: TextStyle(fontSize: 16)),
                                Container(
                                  width: 25,
                                ),
                                Icon(
                                  Icons.access_time,
                                  size: 23,
                                ),
                                Text('15 Minute',
                                    style: TextStyle(fontSize: 16),),
                              ],
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                'ŞEYMAA',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 19 ),
                              ),
                            ),
                          ),
                          Container(
                            height: 18,
                          ),
                          new RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.all(
                              Radius.circular(45.0),
                            )),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaidCards()),
                              );
                            },
                            textColor: Colors.white,
                            color: Color(0xFFee3f46),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 130, vertical: 18),
                            child: new Text("LETS FUN!",
                                style: TextStyle(fontSize: 24, fontFamily: 'Lilita',fontWeight: FontWeight.w400)),
                          )
                        ],
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryContentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: ContentListBloc(BlocProvider.of<AppBloc>(context).firebaseService),
      child: Scaffold(
          backgroundColor: Color(0xFFFAFBFF),
          appBar: AppBar(
            backgroundColor: Color(0xFFFAFAFA),
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF052E44),
                  size: 20.0,
                ),
                onPressed: () {
                  debugPrint("Navigatore tıklandı");
                },
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                transform: Matrix4.translationValues(-25, 4, 0),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 22.0),
              child: Column(
                children: <Widget>[
                  ContentListArea(),
                ],
              ),
            ),
          )),
    );
  }
}

Widget _buildDealsList(BuildContext context, List<DocumentSnapshot> snapshots) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshots.length,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return LibraryWidget(
            contentDetails: Content.fromSnapshot(snapshots[index]));
      });
}

class ContentListArea extends StatefulWidget {
  @override
  ContentListAreaState createState() {
    return new ContentListAreaState();
  }
}

class ContentListAreaState extends State<ContentListArea> {
  ContentListBloc contentListBloc;

  @override
  void initState() {
    super.initState();
    contentListBloc = BlocProvider.of<ContentListBloc>(context);
  }

  @override
  void dispose() {
    contentListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance
                .collection('contents')
                .where("contentImage")
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : _buildDealsList(context, snapshot.data.documents);
            },
          ),
        ],
      ),
    );
  }
}
