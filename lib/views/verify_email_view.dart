import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constant/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
        children: [
          const Text("We've sent you verification.Click on it in order to verify your email",
                      style: TextStyle(
                        color: Colors.purple)
                      ),
          const Text("Click in this if you have'nt received verification yet.",
          style: TextStyle(color: Colors.lightBlueAccent),),
          TextButton(
            onPressed: () async {
              final currentuser = FirebaseAuth.instance.currentUser;
              await currentuser?.sendEmailVerification();
            },
            child: Text('Send email verification'),
          ),
          // Sign Out wala yahan hai
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(loginRoutes, (route) => false);
              }
        },
            child: const Text('Sign Out'),
          ),
          TextButton(
            onPressed: () async{
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoutes,
                (route) => false );
            },
            child: const Text('Restart'))
        ],
      ),
    );
  }
}
