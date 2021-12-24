import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_final/profile.dart';
import 'package:pe_final/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'map.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
                  MaterialPageRoute(builder: (context) => const HomeView()),
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
                            builder: (context) => const MapPage(
                                isSending: true, email: "none@gmail.com")),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapPage(
                                isSending: false,
                                email: "llorenzo@unsa.edu.pe")),
                      );
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
