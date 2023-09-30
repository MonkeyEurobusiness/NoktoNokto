import 'package:flutter/material.dart';
import 'package:noktonokto/data/avatars.dart';


class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

  int _currentAvatar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Center(
        child: Column(
          children: [
              Padding(padding: EdgeInsets.all(32)),
              Text("Hi username!", style: Theme.of(context).textTheme.displaySmall),
              Padding(padding: EdgeInsets.all(16)),
              Row(
                children: [
                  Spacer(),
                  IconButton(onPressed: (){setState(() {
                    _currentAvatar == 0 ? _currentAvatar = 6 : _currentAvatar -= 1;
                  });}, icon: Icon(Icons.arrow_back_rounded, size: 40,)),
                  CircleAvatar(child: Image.asset(avatarAssets[_currentAvatar], width: 120), radius: 100,),
                  IconButton(onPressed: (){setState(() {
                    _currentAvatar == 6 ? _currentAvatar = 0 : _currentAvatar += 1;
                  });}, icon: Icon(Icons.arrow_forward_rounded, size: 40,)),
                  Spacer()
                ],
              ),
          ],
        ),
      )
    );
  }
}
