import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notepad_with_firebase/utils/utils.dart';
import 'package:notepad_with_firebase/view/home_screen.dart';
import '../view_model/add_note_provider.dart';
import 'package:provider/provider.dart';

class AddNoteClass {
  CollectionReference<Map<String, dynamic>> _ref =
      FirebaseFirestore.instance.collection('Users');

  Future add(String uid, String title, String description,
      BuildContext context) async {
    final loadingProvider = Provider.of<AddNoteProvider>(context,listen: false);

    loadingProvider.setLoading(true);
    String noteId = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'noteId': noteId,
      'uid': uid,
    };
    try {
      await _ref
          .doc(uid)
          .collection('Notes')
          .doc(noteId)
          .set(data)
          .then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    } catch (e) {
      Utils.showSnackBar(context, 'Error');
      debugPrint(e.toString());
    }
    loadingProvider.setLoading(false);

  }
}
