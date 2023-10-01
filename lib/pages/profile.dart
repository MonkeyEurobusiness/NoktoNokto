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
              const Padding(padding: EdgeInsets.all(32)),
              Text("Hi username!", style: Theme.of(context).textTheme.displaySmall),
              const Padding(padding: EdgeInsets.all(16)),
              Row(
                children: [
                  const Spacer(),
                  IconButton(onPressed: (){setState(() {
                    _currentAvatar == 0 ? _currentAvatar = 6 : _currentAvatar -= 1;
                  });}, icon: const Icon(Icons.arrow_back_rounded, size: 40,)),
                  CircleAvatar(radius: 100,child: Image.asset(avatarAssets[_currentAvatar], width: 120),),
                  IconButton(onPressed: (){setState(() {
                    _currentAvatar == 6 ? _currentAvatar = 0 : _currentAvatar += 1;
                  });}, icon: const Icon(Icons.arrow_forward_rounded, size: 40,)),
                  const Spacer()
                ],
              ),
            const Padding(padding: EdgeInsets.all(16)),
            Text("EXP", style: Theme.of(context).textTheme.titleLarge),
            Row(
              children: [
                Spacer(),
                SizedBox(width: 300, child: Slider(value: 0.7, onChanged: (double _){})),
                Text("115", style: Theme.of(context).textTheme.titleMedium),
                Spacer()
              ],
            ),
            Spacer(),
            SizedBox(child: FilledButton(onPressed: (){}, child: Text("Log out", style: Theme.of(context).textTheme.titleMedium,)), width: 200, height: 50),
            Padding(padding: EdgeInsets.all(20))
          ],
        ),
      )
    );
  }
}
