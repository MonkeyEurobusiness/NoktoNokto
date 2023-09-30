import 'package:flutter/material.dart';
import 'package:noktonokto/pages/menu.dart';
import 'package:noktonokto/services/user_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controllerUsername = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerPasswordPasswordRepeat = TextEditingController();

  String? get _errorText {
    // at any time, we can get the text from _controllerPassword.text
    final text = _controllerPassword.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.length <= 7 && text.isNotEmpty) {
      return 'Too short';
    }
    if (text.length > 30) {
      return 'Too long';
    }
    // return null if the text is valid
    return null;
  }

  String? get _repeatErrorText {
    // at any time, we can get the text from _controllerPassword.text
    final text = _controllerPasswordPasswordRepeat.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text != _controllerPassword.text && text.isNotEmpty) {
      return 'Passwords are not the same';
    }
    // return null if the text is valid
    return null;
  }

    Future<void> register() async {
    final UserService userService = UserService.getInstance();
    await userService.register(_controllerUsername.text, _controllerEmail.text, _controllerPassword.text);
  }

  void _submit() async {
    if (_errorText == null && _repeatErrorText == null) {
                          try {
                      await register();
                    } catch (e) {
                      print(e);
                      const snackBar = SnackBar(
                        content: Text('Something went wrong. Try again!'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    print('register');
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MenuPage()),
      );
    } else {
                            const snackBar = SnackBar(
                        content: Text('Passwords must be the same an between 7 and 30 characters'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    _controllerPassword.dispose();
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerPasswordPasswordRepeat.dispose();

    super.dispose();
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
              const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Login',
                ),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              TextField(
                obscureText: true,
                controller: _controllerPassword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password', errorText: _errorText),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              TextField(
                obscureText: true,
                controller: _controllerPasswordPasswordRepeat,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Repeat password',
                    errorText: _repeatErrorText),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.secondary),
                  onPressed: _submit,
                  child: Text("Register", style: Theme.of(context).textTheme.titleLarge),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
