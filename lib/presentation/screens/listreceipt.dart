import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Reciept extends StatefulWidget {
  const Reciept({Key? key}) : super(key: key);

  @override
  State<Reciept> createState() => _RecieptState();
}

class _RecieptState extends State<Reciept> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('reciept').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>> querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                querySnapshot.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var imageUrl = documents[index].data()['image']; // Assuming the field name for the image URL is 'image'

                return Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 200,
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
