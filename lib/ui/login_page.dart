import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:momapp/fitness_app/fitness_app_home_screen.dart';
import 'package:momapp/src/calendar_header.dart';
import 'package:momapp/src/weekday_row.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momapp/style/theme.dart' as Theme;
import 'package:momapp/utils/bubble_indication_painter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_calendar_carousel/classes/event.dart';


var dDay = DateTime.parse("1969-07-20"); // 8:18pm
DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);
DateTime currentdata;
DateTime data;
int datas;







class LoginPage extends StatefulWidget {

  DateTime _currentDate = DateTime(2020, 2, 6);
  DateTime _currentDate2 = DateTime(2020, 2, 6);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 6));
  DateTime _targetDateTime = DateTime(2019, 2, 6);
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
  );

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();
  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  DateTime _currentDate = DateTime(2020, 2, 6);
  DateTime _currentDate2 = DateTime(2020, 2, 6);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 6));
  DateTime _targetDateTime = DateTime(2019, 2, 6);
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 680.0
                ? MediaQuery.of(context).size.height
                : 680.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Theme.Colors.loginGradientStart,
                    Theme.Colors.loginGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: new Image(
                      width: 450.0,
                      height: 250.0,
                      image: new AssetImage('assets/img/login_logo.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                        });
                      }
                    },
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignIn(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fonkhesap();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "MOM",
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "BIRTHDAY",
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 350.0,
                  height: 200.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person_outline,
                              color: Colors.black,
                              size: 30.0,
                            ),
                            hintText: "Name",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.control_point,
                              size: 25.0,
                              color: Colors.black,
                            ),
                            hintText: "  Age",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 360.0,
                  height: 260.0,
                  child: Column(
                    children: <Widget>[
                      prefix0.GestureDetector(
                        onTap: () {
                          prefix0.showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: prefix0.Column(
                                    children: <Widget>[
                                      Container(
                                        height: 513,
                                        width: 420,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 45),
                                          child: prefix0.Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    _currentMonth,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24.0,
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    child: Text('PREV'),
                                                    onPressed: () {
                                                      setState(() {
                                                        _targetDateTime =
                                                            DateTime(
                                                                _targetDateTime
                                                                    .year,
                                                                _targetDateTime
                                                                        .month -
                                                                    1);
                                                        _currentMonth = DateFormat
                                                                .yMMM()
                                                            .format(
                                                                _targetDateTime);
                                                      });
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: Text('NEXT'),
                                                    onPressed: () {
                                                      setState(() {
                                                        _targetDateTime =
                                                            DateTime(
                                                                _targetDateTime
                                                                    .year,
                                                                _targetDateTime
                                                                        .month +
                                                                    1);
                                                        _currentMonth = DateFormat
                                                                .yMMM()
                                                            .format(
                                                                _targetDateTime);
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                              _calendarCarouselNoHeader =
                                                  CalendarCarousel<Event>(
                                                todayBorderColor: Colors.amber,
                                                onDayPressed: (DateTime date,
                                                    List<Event> events) {
                                                  this.setState(() =>
                                                      _currentDate2 = date);
                                                  events.forEach((event) =>
                                                      print(event.title));
                                                },
                                                daysHaveCircularBorder: true,
                                                showOnlyCurrentMonthDate: false,
                                                thisMonthDayBorderColor:
                                                    Colors.grey,
                                                weekFormat: false,
                                                height: 420.0,
                                                selectedDateTime: _currentDate2,
                                                targetDateTime: _targetDateTime,
                                                customGridViewPhysics:
                                                    NeverScrollableScrollPhysics(),
                                                showHeader: false,
                                                minSelectedDate:
                                                    _currentDate.subtract(
                                                        Duration(days: 360)),
                                                maxSelectedDate: _currentDate
                                                    .add(Duration(days: 360)),
                                                onCalendarChanged:
                                                    (DateTime date) {
                                                  this.setState(() {
                                                    _targetDateTime = date;
                                                    _currentMonth = DateFormat
                                                            .yMMM()
                                                        .format(
                                                            _targetDateTime);

                                                    var datea = date;
                                                    var dater = date;


                                                    currentdata = date;
                                                      var days = 222;
                                                      currentdata.subtract(Duration(days: days));
                                                  });
                                                },
                                                onDayLongPressed:

                                                    (DateTime date) {
                                                  print(
                                                      'long pressed date $date');
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: Text('Sorulacak Soru ; '),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:75,top: 25),
                            child: Row(children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Colors.pink,
                                size: 24.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                              (Text(
                               ' : '+  formattedDate,
                                style: TextStyle(
                                  fontSize: 22.5,
                                  letterSpacing: 2,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.redAccent,
                                      offset: Offset(5.0, 5.0),
                                    ),
                                  ],
                                ),
                              )),
                            ]),
                          ),
                        ]),
                      ),
                      /*_calendarCarouselNoHeader = CalendarCarousel<Event>(
                        todayBorderColor: Colors.amber,
                        onDayPressed: (DateTime date, List<Event> events) {
                          this.setState(() => _currentDate2 = date);
                          events.forEach((event) => print(event.title));
                        },
                        daysHaveCircularBorder: true,
                        showOnlyCurrentMonthDate: false,
                        thisMonthDayBorderColor: Colors.grey,
                        weekFormat: false,
                        height: 420.0,
                        selectedDateTime: _currentDate2,
                        targetDateTime: _targetDateTime,
                        customGridViewPhysics: NeverScrollableScrollPhysics(),
                        showHeader: false,
                        minSelectedDate:
                            _currentDate.subtract(Duration(days: 360)),
                        maxSelectedDate: _currentDate.add(Duration(days: 360)),
                        onCalendarChanged: (DateTime date) {
                          this.setState(() {
                            _targetDateTime = date;
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                        onDayLongPressed: (DateTime date) {
                          print('long pressed date $date');
                        },
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            //custom icon
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 16.0),
                              child: _calendarCarousel,
                            ), // This trailing comma makes auto-formatting nicer for build methods.
                            //custom icon without header
                            Container(
                              margin: EdgeInsets.only(
                                top: 30.0,
                                bottom: 16.0,
                                left: 16.0,
                                right: 16.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                    _currentMonth,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                                  )),
                                  FlatButton(
                                    child: Text('PREV'),
                                    onPressed: () {
                                      setState(() {
                                        _targetDateTime = DateTime(
                                            _targetDateTime.year,
                                            _targetDateTime.month - 1);
                                        _currentMonth = DateFormat.yMMM()
                                            .format(_targetDateTime);
                                      });
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('NEXT'),
                                    onPressed: () {
                                      setState(() {
                                        _targetDateTime = DateTime(
                                            _targetDateTime.year,
                                            _targetDateTime.month + 1);
                                        _currentMonth = DateFormat.yMMM()
                                            .format(_targetDateTime);
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 16.0),
                              child: _calendarCarouselNoHeader,
                            ), //
                          ],
                        ),
                      )
                    */
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 260.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 5.0,
                    ),
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 5.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [Colors.red[900], Colors.red[900]],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "START",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FitnessAppHomeScreen()),
                      );


                    },
              ),
              )],
          ),
        ],
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget datetime() {
    setState(() {
      var now = new DateTime.now();
    });
  }
}
void fonkhesap(){
  int bab =  2001-21-01;

  int hab = 2019-12-15;

 int sonuc =  hab-bab;

  debugPrint(sonuc.toString());
}