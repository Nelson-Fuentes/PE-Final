import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pe_final/stalkers.dart';

import 'home.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bool switch_value = false;
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
                  MaterialPageRoute(builder: (context) => const ProfileView()),
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
                children:  <Widget>[
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
                        style: ElevatedButton.styleFrom( // fromHeight use double.infinity as width and 40 is the height
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeView()),
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
                  value: switch_value,
                  activeColor: Color(0xFF263238),
                  onChanged: (bool value) {

                  },

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () {
                  },
                  label: Text("GUARDAR"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.visibility),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StalkersView()),
                    );
                  },
                  label: Text("VER STALKERS"),
                ),
              )
            ],
          )
      ),
    );
  }
}