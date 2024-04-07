import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad_with_firebase/utils/constants/colors.dart';
import 'package:notepad_with_firebase/utils/utils.dart';
import 'package:notepad_with_firebase/view/add_note.dart';
import 'package:notepad_with_firebase/view/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notepad'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }).onError((error, stackTrace) {
                Utils.showSnackBar(context, 'Error');
              });
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1), () {
            setState(() {});
          });
        },
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('Notes')
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          int reversedIndex =
                              snapshot.data!.docs.length - index - 1;
                          var jsonData = snapshot.data!.docs[reversedIndex];
                          return ListTile(
                            title: Text(jsonData['title'].toString()),
                            subtitle: Text(jsonData['description'].toString()),
                            trailing: PopupMenuButton(itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  onTap: () {
                                    showDialogBox(
                                      jsonData['title'].toString(),
                                      jsonData['description'].toString(),
                                      jsonData['uid'].toString(),
                                      jsonData['noteId'].toString(),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                      ),
                                      SizedBox(width: width * 0.025),
                                      Text(
                                        'Edit',
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(


                                  onTap: () async {
                                    await deleteNode(jsonData['uid'].toString(),
                                        jsonData['noteId'].toString());
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                      ),
                                      SizedBox(width: width * 0.025),
                                      Text(
                                        'Delete',
                                      ),
                                    ],
                                  ),
                                ),
                              ];
                            }),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          );
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  showDialogBox(String previousTitle, String previousDescription, String uid,
      String noteId) {
    return showDialog(
      context: context,
      builder: (context) {
        _titleController.text = previousTitle;
        _descriptionController.text = previousDescription;
        return AlertDialog(
          title: Text('Update'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: Text('Title'),
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  label: Text('Description'),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await updateNote(_titleController.text,
                    _descriptionController.text, uid, noteId);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateNote(
    String title,
    String description,
    String uid,
    String noteId,
  ) async {
    Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'uid': uid,
      'noteId': noteId,
    };
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Notes')
        .doc(noteId)
        .set(data)
        .then((value) {
      Navigator.pop(context);
      setState(() {});
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      Utils.showSnackBar(context, 'Error');
      setState(() {});
    });
  }

  Future<void> deleteNode(String uid, String noteId) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Notes')
        .doc(noteId)
        .delete()
        .then((value) {
      Navigator.pop(context);
      setState(() {});
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      Utils.showSnackBar(context, 'Error');
    });
  }

}
