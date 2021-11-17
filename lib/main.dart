import 'package:flutter/material.dart';
import 'package:pe_final/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const int red = 200;
  static const int green = 50;
  static const int blue = 56;
  static const Map<int, Color> color =
  {
    50:Color.fromRGBO(red,green,blue, .1),
    100:Color.fromRGBO(red,green,blue, .2),
    200:Color.fromRGBO(red,green,blue, .3),
    300:Color.fromRGBO(red,green,blue, .4),
    400:Color.fromRGBO(red,green,blue, .5),
    500:Color.fromRGBO(red,green,blue, .6),
    600:Color.fromRGBO(red,green,blue, .7),
    700:Color.fromRGBO(red,green,blue, .8),
    800:Color.fromRGBO(red,green,blue, .9),
    900:Color.fromRGBO(red,green,blue, 1),
  };
  final MaterialColor colorCustom = const MaterialColor(0xFF263238, color);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/login.png'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeView()),
                  );
                },
                child: Text("INICIAR SESIÓN"),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
