import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_final/profile.dart';
import 'package:pe_final/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'map.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  late String cadena;
  late bool confirmar = false;

  _HomeView() {}
  getphone(cadena_) {
    cadena = cadena_;
  }

  void getUser(String user_email) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Users').doc(user_email);
    await documentReference.get().then((doc) => {
          if (doc.exists) {confirmar = true} else {confirmar = false}
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Busqueda"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileView()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                flex: 6, // 60% of space => (6/(6 + 4))
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Código',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.vpn_key,
                      ),
                    ),
                    onChanged: (String a) {
                      setState(() {
                        cadena = a;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2, // 40% of space
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        // fromHeight use double.infinity as width and 40 is the height
                        ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MapPage(isSending: true, email: "")),
                      );
                    },
                    child: Icon(Icons.cloud_upload_outlined, size: 30),
                  ),
                ),
              ),
              Expanded(
                flex: 2, // 40% of space
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        // fromHeight use double.infinity as width and 40 is the height
                        ),
                    onPressed: () {
                      getUser(cadena);
                      if (confirmar) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MapPage(isSending: false, email: cadena)),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Error '),
                                    content: const Text(
                                        'No se ha podido confirmar la existencia del correo'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ]));
                      }
                    },
                    child: Icon(Icons.cloud_download_outlined, size: 30),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(64.0),
            child: Image.asset('assets/images/world.png'),
          ),
        ],
      )),
    );
  }
}
