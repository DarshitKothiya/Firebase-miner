import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../helper/FirestoreHelper.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe63946),
        title: Text(
          'Homepage',
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xfff1faee),
      body: StreamBuilder(
        stream: FireStoreHelper.fireStoreHelper.fetchAuthorData(),
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

                Uint8List image = base64.decode(data[i]['image']);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      Container(
                        height: 150,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                          image: DecorationImage(
                            image: MemoryImage(image)
                          )
                        ),
                      )
                    ],
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
          Navigator.of(context).pushNamed('author_page');
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}
