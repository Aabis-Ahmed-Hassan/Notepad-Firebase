import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad_with_firebase/view_model/add_note_class.dart';

import '../utils/components/my_button.dart';
import '../utils/constants/colors.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  bool _loading = false;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                label: Text(
                  'Title',
                ),
                hintText: 'Please enter the title',
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                label: Text(
                  'Description',
                ),
                hintText: 'Please enter the description',
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            MyButton(
              title: 'Add Note',
              onTap: () async {
                setState(() {
                  _loading = true;
                });
                await AddNoteClass().add(uid, _titleController.text,
                    _descriptionController.text, context);
                setState(
                  () {
                    _loading = false;
                  },
                );
              },
              loading: _loading,
            ),
          ],
        ),
      ),
    );
  }
}
