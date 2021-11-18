import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StalkersView extends StatelessWidget {
  const StalkersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bool switch_value = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("Stalkers"),
      ),
      body: Center(
          child: ListView(
            children: const [
              ListTile(
                title: Text('Nombre de Usuario'),
                subtitle: Text('2021-10-08 20:00:00'),
                leading: CircleAvatar(
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
                    icon: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    onPressed: null,
                  ),
                ),
              ),
              ListTile(
                title: Text('Nombre de Usuario'),
                subtitle: Text('2021-10-08 20:00:00'),
                leading: CircleAvatar(
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
                    icon: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    onPressed: null,
                  ),
                ),
              ),
              ListTile(
                title: Text('Nombre de Usuario'),
                subtitle: Text('2021-10-08 20:00:00'),
                leading: CircleAvatar(
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
                    icon: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    onPressed: null,
                  ),
                ),
              ),
              ListTile(
                title: Text('Nombre de Usuario'),
                subtitle: Text('2021-10-08 20:00:00'),
                leading: CircleAvatar(
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
                    icon: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    onPressed: null,
                  ),
                ),
              ),
              ListTile(
                title: Text('Nombre de Usuario'),
                subtitle: Text('2021-10-08 20:00:00'),
                leading: CircleAvatar(
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
                    icon: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    onPressed: null,
                  ),
                ),
              ),

            ],
          )
      ),
    );
  }
}