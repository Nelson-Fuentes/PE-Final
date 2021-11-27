import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pe_final/main.dart';
import 'package:pe_final/models/user.dart';
import 'package:pe_final/provider/google_sign_in.dart';
import 'package:pe_final/stalkers.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  final user_ = FirebaseAuth.instance.currentUser!;
  //var user_firebase = Usuario();

  String code = "", condition = "", phone = "", status = "";
  num latitud = 0.0, longitud = 0.0;

  getcode(code_) {
    this.code = code_;
  }

  getcondition(condition_) {
    this.condition = condition_;
  }

  getphone(phone_) {
    this.phone = phone_;
  }

  getstatus(status_) {
    this.status = status_;
  }

  void getUser() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Users').doc(user_.email);

    await documentReference.get().then((doc) => {
          if (doc.exists) {chargeUser(documentReference)} else {}
        });
  }

  void saveUser() async {
    Map<String, dynamic> pat = {
      "code": this.code,
      "condition": this.condition,
      "latitude": this.latitud,
      "longitude": this.longitud,
      "phone": this.phone,
      "status": this.status
    };

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user_.email)
        .set(pat)
        .whenComplete(() {
      print("actualizado");
    });
  }

  void createUser() async {
    Map<String, dynamic> pat = {
      "code": this.code,
      "condition": this.condition,
      "latitude": this.latitud,
      "longitude": this.longitud,
      "phone": this.phone,
      "status": this.status
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Users");
    collectionReference.add(pat).whenComplete(() {
      print("registrado");
    });
  }

  void chargeUser(DocumentReference document) async {
    DocumentSnapshot user_1 = await document.get();
    Map<String, dynamic> data = user_1.data()! as Map<String, dynamic>;
    getcode(data['code']);
    getcondition(data['condition']);
    getphone(data['phone']);
    getstatus(data['status']);
  }

  @override
  Widget build(BuildContext context) {
    //var bool switch_value = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil de Usuario"),
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
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
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
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(user_.photoURL!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              initialValue: user_.displayName!,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.people,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              initialValue: user_.email!,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.email,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 6, // 60% of space => (6/(6 + 4))
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    initialValue: this.code,
                    decoration: const InputDecoration(
                      labelText: 'Código',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.vpn_key,
                      ),
                    ),
                    onChanged: (String _code) {
                      getcode(_code);
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2, // 40% of space
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        // fromHeight use double.infinity as width and 40 is the height
                        ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeView()),
                      );
                    },
                    child: Icon(Icons.sync, size: 18),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              initialValue: this.phone,
              decoration: const InputDecoration(
                labelText: 'Telefono',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.call,
                ),
              ),
              onChanged: (String _p) {
                getphone(_p);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              initialValue: this.condition,
              decoration: const InputDecoration(
                labelText: 'Condicion',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.security_update_warning_sharp,
                ),
              ),
              onChanged: (String _c) {
                getcondition(_c);
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Compartir Ubicación',
            ),
            leading: Switch(
              value: false,
              activeColor: Color(0xFF263238),
              onChanged: (bool value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.save),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () {
                saveUser();
              },
              label: Text("GUARDAR"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.visibility),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StalkersView()),
                );
              },
              label: Text("VER SEGUIDORES"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.logout),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logOut().then((value) => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MyHomePage(title: 'Titulo')))
                    });
              },
              label: Text("FINALIZAR SESION"),
            ),
          )
        ],
      )),
    );
  }
}

mixin UserId {}
