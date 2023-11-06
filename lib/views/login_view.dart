import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rappproj/constants/routes.dart';
import 'package:rappproj/utilities/show_error_dialog.dart';

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
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (_) => false,
                  );
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'invalid-email') {
                  await showErrorDialog(
                    context,
                    "Invalid Email",
                  );
                } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                  await showErrorDialog(
                    context,
                    "Wrong Credentials",
                  );
                } else if (e.code == 'too-many-requests') {
                  await showErrorDialog(
                    context,
                    "Too many requests, try again later",
                  );
                } else {
                  await showErrorDialog(
                    context,
                    "Erorr: ${e.code}",
                  );
                }
              } catch (e) {
                await showErrorDialog(
                  context,
                  "Erorr: ${e.toString()}",
                );
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text("Not registered yet? Register here"),
          ),
        ],
      ),
    );
  }
}
