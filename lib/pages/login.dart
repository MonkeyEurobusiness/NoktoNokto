import 'package:flutter/material.dart';
import 'package:noktonokto/pages/camera.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Login',
              ),
            ),
             TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print('login');
                Navigator.push(context,MaterialPageRoute(builder: (context) => const CameraPage()),);
                }, 
                child: const Text("Login")
              )
          ],
        ),
      ),
    );
  }
}
