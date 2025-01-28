import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:levelstudio_app/schemas/get_users.dart';

class UsersS {
  final GraphQLClient client;

  UsersS(this.client);

  Future<List<Map<String, dynamic>>> fetchUsers() async {

    final QueryResult result =
        await client.query(QueryOptions(document: gql(GET_USERS)));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    // Imprime los datos crudos antes de procesarlos
    // print("Datos crudos del backend: ${result.data}");

    final usersData = result.data?['users'];
    if (usersData == null || usersData.isEmpty) {
      throw Exception("No users found or data is null");
    }

    return (usersData as List)
        .map((user) => {
              "name": user['name'],
              "lastname": user['lastname'],
              "age": user['age'],
            })
        .toList();
  }
}