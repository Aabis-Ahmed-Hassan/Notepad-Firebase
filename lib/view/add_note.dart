import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad_with_firebase/utils/utils.dart';
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

  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
  }

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
              focusNode: _titleFocusNode,
              controller: _titleController,
              onFieldSubmitted: (val) {
                Utils.changeFocus(
                    _titleFocusNode, _descriptionFocusNode, context);
              },
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
              focusNode: _descriptionFocusNode,
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
