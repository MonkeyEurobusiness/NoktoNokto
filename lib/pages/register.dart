import 'package:flutter/material.dart';
import 'package:noktonokto/pages/menu.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controller = TextEditingController();
  final _controllerPasswordRepeat = TextEditingController();

  String _password = "";
  String _text =  "";

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _controller.value.text;
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
    // at any time, we can get the text from _controller.value.text
    final text = _controllerPasswordRepeat.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text != _controller.value.text && text.isNotEmpty) {
      return 'Passwords are not the same';
    }
    // return null if the text is valid
    return null;
  }

  void _submit() async
  {
    if (_errorText == null) {
      print('login');
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MenuPage()),);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
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
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  errorText: _errorText
                ),
                onChanged: (text) => setState(() => _password),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              TextField(
                obscureText: true,
                controller: _controllerPasswordRepeat,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Repeat password',
                  errorText: _repeatErrorText
                ),
                onChanged: (text) => setState(() => _text),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
                  onPressed: _controller.value.text.isNotEmpty
                  ? _submit
                  : null,
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
