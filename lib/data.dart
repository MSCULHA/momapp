import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:momapp/addplayer.dart';
import 'package:shared_preferences/shared_preferences.dart';





final ios = defaultTargetPlatform == TargetPlatform.iOS;
var app_secret = ios ? "123cfac9-123b-123a-123f-123273416a48" : "321cfac9-123b-123a-123f-123273416a48";


List<Widget> content;
List<Widget> contents;

List<String> randomuser = [];
List<String> userdata = [];

String outRandom;
String plText;
String plTexts;
String text;


final formKey = GlobalKey<FormState>();
final formKey2 = GlobalKey<FormState>();
final formKey3 = GlobalKey<FormState>();
final formKey4 = GlobalKey<FormState>();

int userinput1scor = 0;
int userinput2scor = 0;
int userinput3scor = 0;
int userinput4scor = 0;


String userinput1;
String userinput2;
String userinput3;
String userinput4;

List<String> contentss;



String stringValue;
getValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  stringValue = prefs.getString('stringValue');

}

bool isPremium;
List<Widget> books;
List<Widget> library;
List<String> readList;
String lastRead;
String contentDesc;
var userDocument;
List<IAPItem> iaps = [];

List<String> favorites;

String selectedCategory;

initIAPs() async {
  var result = await FlutterInappPurchase.instance.initConnection;
  print(FlutterInappPurchase.instance);
  print("Established IAP Connection..." + result);
  iaps = await FlutterInappPurchase.instance
      .getSubscriptions(['permonthly', 'peryear', 'per6month']);
  print(iaps);
  for (var i = 0; i < iaps.length; ++i) {
    print(iaps[i].title + " " + iaps[i].price);
  }
}

Future<Null> getPurchaseHistory() async {
  List<PurchasedItem> items =
  await FlutterInappPurchase.instance.getPurchaseHistory();
  if (items.length != 0 && items.length != null) {
    isPremium = true;



    print("isPremium = true");
  } else {
    isPremium = false;
    print("isPremium = false");
  }
  print(items);
  for (var item in items) {
    print('${item.toString()}');
    purchases.add(item);
    print(purchases);
    print(purchases.length);
  }
  items = [];
  purchases = items;
}

void getLocalData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getBool('isPremium') != null) {
    isPremium = prefs.getBool('isPremium');
  }
  if (prefs.getBool('isPremium') == null) {
    isPremium = false;
    prefs.setBool('isPremium', isPremium);
  }

}



void setLocalData(String key, List<String> value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(key, value);
}

List<String> images = [];

List<String> title = [];
List purchases = [];
List items = [];
List<int> itemler = [];
