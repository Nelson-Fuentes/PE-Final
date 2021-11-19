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
  //const ProfileView({Key? key}) : super(key: key);

  final user_ = FirebaseAuth.instance.currentUser!;
  var user_firebase = Usuario();

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

    DocumentSnapshot user = await documentReference.get();
    Map<String, dynamic> data = user.data()! as Map<String, dynamic>;
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
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(user_.photoURL!),
          ),
          Text(
            'Nombre: ' + user_.displayName!,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Text(
            'Correo: ' + user_.email!,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
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
                  ),
                ),
              ),
              Expanded(
                flex: 2, // 40% of space
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
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
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              //initialValue: ,
              decoration: const InputDecoration(
                labelText: 'Telefono',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.call,
                ),
              ),
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
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.save),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () {},
              label: Text("GUARDAR"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
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
              label: Text("VER STALKERS"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.logout),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyHomePage(title: 'Titulo')));
              },
              label: Text("Log Out"),
            ),
          )
        ],
      )),
    );
  }
}

mixin UserId {}
