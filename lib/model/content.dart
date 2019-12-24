import 'package:cloud_firestore/cloud_firestore.dart';


class Content {
  final String contentName;
  final String contentImage;
  final bool isPremium;
  final String contentPeopleNumber;
  final String contentDescription;
  final String contentTimer;
  

  final List contentText;

 

  Content.fromMap(Map<String, dynamic> map)
      : assert(map['contentPeopleNumber'] != null),
        assert(map['contentTimer'] != null),
        assert(map['isPremium'] != null),
        assert(map['contentDescription'] != null),
        assert(map['contentImage'] != null),
        assert(map['contentName'] != null),
        assert(map['contentText'] != null),

        contentPeopleNumber = map['contentPeopleNumber'],
        isPremium = map['isPremium'],
        contentTimer = map['contentTimer'],
        contentDescription = map['contentDescription'],
        contentImage = map['contentImage'],
        contentName = map['contentName'],
        contentText = map['contentText'];



  Content.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);

}


