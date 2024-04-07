import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
    );
  }
}
