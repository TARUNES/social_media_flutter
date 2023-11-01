import 'package:flutter/material.dart';
import 'package:social_media/components/my_drawer.dart';
import 'package:social_media/components/my_listtile.dart';
import 'package:social_media/components/my_post_button.dart';
import 'package:social_media/components/my_textfield.dart';
import 'package:social_media/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController newpost = TextEditingController();

  final FirestoreDatabase database = FirestoreDatabase();

  void PostMessage() {
    if (newpost.text.isNotEmpty) {
      String message = newpost.text;
      database.addPost(message);
    }
    newpost.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
        title: Text(
          'Home',
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              Expanded(
                child: MyTextField(
                    hintText: "Say Something..",
                    obsecureText: false,
                    controller: newpost),
              ),
              PostButton(onTap: PostMessage),
            ],
          ),
        ),
        StreamBuilder(
            stream: database.getPostStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final posts = snapshot.data!.docs;

              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No Posts"),
                  ),
                );
              }

              return Expanded(
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];

                        String message = post['PostMessage'];
                        String userEmail = post['UserEmail'];
                        // String timestamp = post['Timestamp'];

                        return MyListTile(title: message, subtitle: userEmail);
                      }));
            })
      ]),
    );
  }
}
