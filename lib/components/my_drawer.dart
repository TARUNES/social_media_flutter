import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            DrawerHeader(
                child: Icon(Icons.favorite,
                    color: Theme.of(context).colorScheme.inversePrimary)),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: Icon(Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary),
                title: const Text('H O M E'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home_page');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: Icon(Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary),
                title: const Text('P R O F I L E'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile_page');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: Icon(Icons.group,
                    color: Theme.of(context).colorScheme.inversePrimary),
                title: const Text('U S E R S'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/users_page');
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 25),
          child: ListTile(
            leading: Icon(Icons.logout,
                color: Theme.of(context).colorScheme.inversePrimary),
            title: const Text('L O G O U T'),
            onTap: () {
              Navigator.pushNamed(context, '/auth_page');

              logout();
            },
          ),
        ),
      ]),
    );
  }
}
