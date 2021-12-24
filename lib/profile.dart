import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pe_final/main.dart';
import 'package:pe_final/models/user.dart';
import 'package:pe_final/provider/google_sign_in.dart';
import 'package:pe_final/stalkers.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'home.dart';

class ProfileView extends StatelessWidget {
  var ui = Uuid();

  final user_ = FirebaseAuth.instance.currentUser!;
  String code = "", condition = "a", phone = "a", status = "a";
  num latitud = 0.0, longitud = 0.0;

  getcode(code_) {
    code = ui.v1();
  }

  getcondition(condition_) {
    condition = condition_;
  }

  getphone(phone_) {
    phone = phone_;
  }

  getstatus(status_) {
    status = status_;
  }

  void saveUser() async {
    Map<String, dynamic> pat = {
      "name": user_.displayName,
      "email": user_.email,
      "code": this.code,
      "condition": this.condition,
      "latitude": this.latitud,
      "longitude": this.longitud,
      "phone": this.phone,
      "status": false
    };

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user_.email)
        .set(pat)
        .whenComplete(() {
      print("actualizado");
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(user_.email)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (!snapshot.hasData) {
                return Text("Loading 2 ");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              var userDocument = snapshot.data!;
              //= userDocument["code"];
              final code_ = userDocument["code"];
              final condition_ = userDocument["condition"];
              final phone_ = userDocument["phone"];
              code = code_;
              condition = condition_;
              phone = phone_;

              return Center(
                  child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: Image.network(
                          user_.photoURL!,
                        ),
                      ),
                      //backgroundImage: NetworkImage(user_.photoURL!),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
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
                    padding: const EdgeInsets.all(12.0),
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
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            initialValue: code_,
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
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                // fromHeight use double.infinity as width and 40 is the height
                                ),
                            onPressed: () {
                              getcode("a");
                            },
                            child: Icon(Icons.sync, size: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      initialValue: phone_,
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
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      initialValue: condition_,
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
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
                          MaterialPageRoute(
                              builder: (context) => StalkersView()),
                        );
                      },
                      label: Text("VER SEGUIDORES"),
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
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
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
              ));
            }));
  }
}
