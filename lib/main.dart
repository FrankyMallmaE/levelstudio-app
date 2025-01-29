import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:levelstudio_app/components/users/views/users.dart';

void main() async {
  
  await initHiveForFlutter(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuración del HttpLink con  URL de ngrok
    final HttpLink httpLink = HttpLink(
      'https://9c84-45-190-170-23.ngrok-free.app/query',
    );

   
    final GraphQLClient client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()), 
    );

    
    return GraphQLProvider(
      client: ValueNotifier(client),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Levelstudio Users',
        //theme: ThemeData(primarySwatch: Colors.blue),
        home: SafeArea(child: HomeScreen()),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final List<Widget> _pages = [
    const Users(),
    const Text("user"),
  ];

  // final List<String> _iconPaths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Usuarios",
      //     style: TextStyle(
      //       fontSize: 16,
      //       fontWeight: FontWeight.w400,
      //     ),
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_open,
              ),
              label: "Usuarios"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Cuenta"),
        ],
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
      body: SafeArea(child: _pages[_index]),
    );
  }
}
