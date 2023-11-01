import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/my_button.dart';
import 'package:social_media/components/my_textfield.dart';
import 'package:social_media/helper/helperfunctions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  void register() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    if (passwordController.text != confirmpasswordController.text) {
      Navigator.pop(context);
      displayMsgToUser("Password Does'nt Match", context);
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        createUserDocument(userCredential);
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMsgToUser(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        "email": userCredential.user!.email,
        "username": usernameController.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.person,
                size: 80, color: Theme.of(context).colorScheme.inversePrimary),
            const SizedBox(height: 25),
            const Text(
              "T H E   W A L L",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            MyTextField(
                hintText: "Username",
                obsecureText: false,
                controller: usernameController),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
                hintText: "Email",
                obsecureText: false,
                controller: emailController),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
                hintText: "Password",
                obsecureText: true,
                controller: passwordController),
            const SizedBox(
              height: 7,
            ),
            MyTextField(
                hintText: "Confirm Password",
                obsecureText: true,
                controller: confirmpasswordController),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              text: "Register",
              onTap: register,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?  ",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ]),
        ),
      )),
    );
  }
}
