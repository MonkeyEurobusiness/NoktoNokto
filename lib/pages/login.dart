import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:noktonokto/pages/menu.dart';
import 'package:noktonokto/services/user_service.dart';

import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final UserService userService = UserService.getInstance();
    await userService.login(usernameController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               TextField(
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Login',
                ),
                controller: usernameController,
              ),
              const Padding(padding: EdgeInsets.all(12)),
               TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                controller: passwordController,
              ),
              const Padding(padding: EdgeInsets.all(12)),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.secondary),
                  onPressed: () async {
                    try {
                      await login();
                    } catch (e) {
                      print(e);
                      const snackBar = SnackBar(
                        content: Text('Invalid credentials. Try again!'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    print('login');
                    await Future.delayed(const Duration(milliseconds: 500));
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MenuPage()),
                    );
                  },
                  child: Text("Login", style: Theme.of(context).textTheme.titleLarge),
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  Text("Don't have account yet?", style: Theme.of(context).textTheme.titleMedium),
                  TextButton(
                      onPressed: () async {
                        await Future.delayed(const Duration(milliseconds: 500));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        );
                      },
                      child: Text("Register",
                          style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))),
                  const Spacer()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
