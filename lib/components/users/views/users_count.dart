import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:levelstudio_app/schemas/get_users.dart';

class UsersCount extends StatefulWidget {
  const UsersCount({super.key});

  @override
  State<UsersCount> createState() => _UsersCountState();
}

class _UsersCountState extends State<UsersCount> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(GET_USERS),
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Center(child: Text('Error: ${result.exception.toString()}'));
        }

        if (result.isLoading) {
          return const CircularProgressIndicator();
        }

        final int userCount = (result.data!['users'] as List).length;

        return Text(
          'Registros: $userCount',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFa5a5a5),
          ),
        );
      },
    );
  }
}
