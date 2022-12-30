import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/FirestoreHelper.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff84a98c),
        title: const Text(
          'Homepage',
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xfffefae0),
      body: StreamBuilder(
        stream: FireStoreHelper.fireStoreHelper.fetchNoteData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot? res = snapshot.data;
            List<QueryDocumentSnapshot> data = res!.docs;

            return ListView.builder(
              itemCount: data.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: (){
                    updateNote(data: data[i],id: data[i].id);
                  },
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xffccd5ae),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(color: Colors.black,),
                        Center(child: Text('Title : ${data[i]['title']}',style: GoogleFonts.balooBhai2(fontSize: 18),)),
                        Divider(color: Colors.black,),
                        SizedBox(height: 115,child: Text('Note : ${data[i]['note']}')),
                        Divider(color: Colors.black,),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
              backgroundColor: Colors.transparent,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertNote();
        },
        backgroundColor: const Color(0xff84a98c),
        child: const Icon(Icons.add),
      ),
    );
  }

  insertNote() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: Text('ADD Note'),
          ),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Enter Note title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 250,
                    child: TextFormField(
                      controller: noteController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: 'Enter Note',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> data = {
                  'title': titleController.text,
                  'note': noteController.text,
                };

                if (formKey.currentState!.validate()) {
                  DocumentReference docRef = await FireStoreHelper
                      .fireStoreHelper
                      .insertNoteData(data: data);


                  titleController.clear();
                  noteController.clear();

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Note Added...'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
            OutlinedButton(
              onPressed: () {
                titleController.clear();
                noteController.clear();
              },
              child: const Text('cancel'),
            ),
          ],
        );
      },
    );
  }

  updateNote({required QueryDocumentSnapshot data, required String id}) {

    noteController.value = TextEditingValue(text: data['note']);
    titleController.value = TextEditingValue(text: data['title']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: Text('Update Note'),
          ),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Enter Note title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 250,
                    child: TextFormField(
                      controller: noteController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: 'Enter Note',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> data = {
                  'title': titleController.text,
                  'note': noteController.text,
                };

                if (formKey.currentState!.validate()) {
                  FireStoreHelper.fireStoreHelper.updateNoteData(data: data, id: id);


                  titleController.clear();
                  noteController.clear();

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Note Updated...'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text('update'),
            ),
            ElevatedButton(
              onPressed: () async {

                  FireStoreHelper.fireStoreHelper.deleteNoteData(id: id);


                  titleController.clear();
                  noteController.clear();

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Note Deleted...'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
              },
              child: const Icon(Icons.delete),
            ),
            OutlinedButton(
              onPressed: () {
                titleController.clear();
                noteController.clear();
              },
              child: const Text('cancel'),
            ),
          ],
        );
      },
    );
  }
}
