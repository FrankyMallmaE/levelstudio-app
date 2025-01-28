import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:levelstudio_app/hooks/users/use_get_users.dart';
import 'package:levelstudio_app/types/user.dart';

class ColumnsUser extends StatefulWidget {
  const ColumnsUser({super.key});

  @override
  State<ColumnsUser> createState() => _ColumnsUserState();
}

class _ColumnsUserState extends State<ColumnsUser> {
  @override
  Widget build(BuildContext context) {
    final UsersS users = UsersS(
      GraphQLProvider.of(context).value,
    );

    return Expanded(
      child: FutureBuilder<List<User>>(
        future: users
            .fetchUsers()
            .then((data) => data.map((json) => User.fromJson(json)).toList()),
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
    );
  }
}
