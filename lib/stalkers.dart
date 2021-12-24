import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class StalkersView extends StatelessWidget {
  final user_ = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(user_.email)
        .collection("followers")
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: Text("Stalkers"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data["name"]),
                  subtitle: Text(data["date"]),
                  leading: const CircleAvatar(
                    radius: 36,
                    backgroundColor: Color(0xffD1338E),
                    child: IconButton(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xff2ECC71),
                    child: IconButton(
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        FlutterPhoneDirectCaller.callNumber(data["number"]);
                        print("llamando" + data["number"]);
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
