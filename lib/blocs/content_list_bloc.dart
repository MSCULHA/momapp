import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:momapp/api/services.dart';
import 'package:momapp/blocs/bloc_provider.dart';

class ContentListBloc implements BlocBase {
    StreamController<QuerySnapshot> contentController = StreamController<QuerySnapshot>();

  StreamSink<QuerySnapshot> get dealsSink => contentController.sink;

  Stream<QuerySnapshot> get dealsStream => contentController.stream;

  ContentListBloc(FirebaseService firebaseService) {
    firebaseService.getContent().listen((event) {
      dealsSink.add(event);
    });
  }


  @override
  void dispose() {
    contentController.close();
    //contentsByCategoryController.close();
  }

}
