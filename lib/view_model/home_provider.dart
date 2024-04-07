import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  Future<QuerySnapshot<Map<String, dynamic>>>? _allNotes;

  Future<QuerySnapshot<Map<String, dynamic>>> get allNotes => _allNotes!;

  Future<void> refreshNotes() async {
    _allNotes = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Notes')
        .get();
    notifyListeners();
  }
}
