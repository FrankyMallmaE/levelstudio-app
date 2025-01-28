import 'package:flutter/material.dart';
import 'package:levelstudio_app/components/users/views/users_count.dart';
import 'package:levelstudio_app/reports/users/src/columns_user.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
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
            const ColumnsUser(),
          ],
        ),
      ),
    );
  }
}
