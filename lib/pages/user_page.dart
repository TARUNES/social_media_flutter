import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/my_listtile.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return Text("No Data");
          }
          final users = snapshot.data!.docs;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 50),
                child: Row(
                  children: [
                    BackButton(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    final email = user['email'];

                    final username = user['username'];

                    return MyListTile(title: email, subtitle: username);
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
