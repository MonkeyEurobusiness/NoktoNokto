import 'package:flutter/material.dart';
import 'package:noktonokto/data/avatars.dart';


class ChatMockWidget extends StatefulWidget {
  @override
  _ChatMockWidgetState createState() => _ChatMockWidgetState();
}

class _ChatMockWidgetState extends State<ChatMockWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Row(
          children: [
            CircleAvatar(child: Image.asset(avatarAssets[2], height: 30,), radius: 20,),
            Padding(padding: EdgeInsets.all(12)),
            Text("jakubhulek21"),
          ],
        ), ),
        body: Column(
          children: [
            Row(
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(20, 30, 10, 10),
                  child: SizedBox(height: 50, child:
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(12)),
                      Column(
                        children: [
                          Spacer(),
                          Text("Dzień dobry"),
                          Spacer()
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(12)),
                    ],
                  )),
                ),
                Padding(padding: EdgeInsets.all(30))
              ],
            ),
            Row(
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: SizedBox(height: 50, child:
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(12)),
                      Column(
                        children: [
                          Spacer(),
                          Text("Znalazł pan kota przy ul. Czarnowiejskiej"),
                          Spacer()
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(12)),
                    ],
                  )),
                ),
                Padding(padding: EdgeInsets.all(30))
              ],
            ),
            Row(
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: SizedBox(height: 50, child:
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(12)),
                      Column(
                        children: [
                          Spacer(),
                          Text("Czy miał on niebieską obroze?"),
                          Spacer()
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(12)),
                    ],
                  )),
                ),
                Padding(padding: EdgeInsets.all(30))
              ],
            ),
            Row(
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: SizedBox(height: 50, child:
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(12)),
                      Column(
                        children: [
                          Spacer(),
                          Text("Proszę o pilny kontakt"),
                          Spacer()
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(12)),
                    ],
                  )),
                ),
                Padding(padding: EdgeInsets.all(30))
              ],
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
    );
  }
}
