import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:levelstudio_app/components/users/views/users_count.dart';
import 'package:levelstudio_app/reports/users/src/columns_user.dart';
import 'package:levelstudio_app/reports/users/users.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    final UsersS users = UsersS(
      GraphQLProvider.of(context).value,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuarios"),
        backgroundColor: const Color(0xFFFAFCFF),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        color: const Color(0xFFF6F5F1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 10),
                child: const UsersCount()),
            Expanded(
              child: FutureBuilder<List<User>>(
                future: users.fetchUsers().then(
                    (data) => data.map((json) => User.fromJson(json)).toList()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  // Obtén los datos si están disponibles
                  final users = snapshot.data ?? [];

                  // Comprueba si la lista está vacía
                  if (users.isEmpty) {
                    return const Center(
                      child: Text('No hay usuarios disponibles.'),
                    );
                  }

                  // Muestra la lista de usuarios
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        margin: const EdgeInsets.all(4),
                        elevation: 0,
                        color: const Color(0xFFE2E0DE),
                        child: ListTile(
                          title: Text(user.name),
                          subtitle: Text(
                            user.lastname,
                          ),
                          trailing: Text(
                            '${user.age} años',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
