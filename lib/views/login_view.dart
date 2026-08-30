import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:mynotes/constant/routes.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Enter Your E-mail"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: "Enter Your Password"),
          ),
          TextButton(
            onPressed: () async {
              try {
                final email = _email.text;
                final password = _password.text;
                await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                devtools.log('Login Successful');
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(noteRoutes,
                (route) => false,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found' ||
                    e.code == 'invalid-credential') {
                  await showErrorDialog(context,'Wrong email or password',);
                } else if (e.code == 'wrong-password') {
                  await showErrorDialog(context,'Wrong email or password',);
                } else {
                  await showErrorDialog(context,'Error : ${e.code}',);
                }
              } catch (e) {
                  await showErrorDialog(context, e.toString(),);
              }
            },
            child: Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoutes, (route) => false);
            },
            child: const Text('Register Now'),
          ),
        ],
      ),
    );
  }
}