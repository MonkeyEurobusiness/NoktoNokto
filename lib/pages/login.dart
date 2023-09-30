import 'package:flutter/material.dart';
import 'package:noktonokto/pages/menu.dart';

import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Login',
                ),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
                  onPressed: () async {
                    print('login');
                    await Future.delayed(const Duration(milliseconds: 500));
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const MenuPage()),);
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
                      Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterPage()),);
                    },
                    child: Text("Register", style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))),
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
