import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo_velha/core/database/db.dart';
import 'package:jogo_velha/features/jogo/page/jogo_page.dart';
import 'package:jogo_velha/features/jogo/page/selecionar_players_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = Db();
  await db.openDb();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da Velha',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Jogo da Velha 2.0"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset("assets/Logo.png"),
          ),
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SelecionarPlayersPage(
                      isSinglePlayer: false,
                    ),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_outlined),
                  SizedBox(
                    width: 12,
                  ),
                  Text("Vs Player"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SelecionarPlayersPage(
                      isSinglePlayer: true,
                    ),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.computer_outlined),
                  SizedBox(
                    width: 12,
                  ),
                  Text("Vs CPU"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.door_back_door_outlined),
                  SizedBox(
                    width: 12,
                  ),
                  Text("Sair"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
