import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  static final firestore = FirebaseFirestore.instance;

  CollectionReference ecoThinkers =
      FirebaseFirestore.instance.collection('eco_thinkers');

  // Future<void> addUser() async {}
}
