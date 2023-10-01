import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:noktonokto/data/avatars.dart';
import 'package:noktonokto/services/encounter_service.dart';


class ChatWidget extends StatefulWidget {
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(20)),
              Text("Alert results", style: Theme.of(context).textTheme.headlineSmall),
              Padding(padding: EdgeInsets.all(8)),
              CarouselSlider(
                options: CarouselOptions(height: 300.0, viewportFraction: 0.8),
                items: getMockEncounters().map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        child: Card(
                          elevation: 5,
                          color: Theme.of(context).colorScheme.tertiary,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: SizedBox(
                              height: 250,
                              child: Column(
                                children: [
                                  Image.network(i.imageUrls[0], height: 200,),
                                  Spacer(),
                                  Text("${i.description}", style: Theme.of(context).textTheme.titleMedium),
                                  Padding(padding: EdgeInsets.all(3)),
                                  FilledButton(onPressed: (){}, child: Text("Show on map")),
                                  Padding(padding: EdgeInsets.all(4))
                                ],
                              ),
                            )
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Padding(padding: EdgeInsets.all(6)),
              Divider(),
              Padding(padding: EdgeInsets.all(6)),
              Text("Chats", style: Theme.of(context).textTheme.headlineSmall),
              Padding(padding: EdgeInsets.all(6)),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      CircleAvatar(radius: 30, child: Image.asset(avatarAssets[0], height: 35,)),
                      Spacer(),
                      const Column(
                        children: [
                          Spacer(),
                          Text("Dziekan65", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold)),
                          Padding(padding: EdgeInsets.all(2)),
                          Text("Masz jakies warunki kurde ten", textAlign: TextAlign.left),
                          Spacer()
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                )
              ),
              Padding(padding: EdgeInsets.all(6)),
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        CircleAvatar(radius: 30, child: Image.asset(avatarAssets[1], height: 35,)),
                        Spacer(),
                        const Column(
                          children: [
                            Spacer(),
                            Text("Dziekan66", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold)),
                            Padding(padding: EdgeInsets.all(2)),
                            Text("Masz jakies warunki kurde ten", textAlign: TextAlign.left),
                            Spacer()
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  )
              ),
              Padding(padding: EdgeInsets.all(6)),
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        CircleAvatar(radius: 30, child: Image.asset(avatarAssets[2], height: 35,)),
                        Spacer(),
                        const Column(
                          children: [
                            Spacer(),
                            Text("Dziekan67", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold)),
                            Padding(padding: EdgeInsets.all(2)),
                            Text("Masz jakies warunki kurde ten", textAlign: TextAlign.left),
                            Spacer()
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  )
              )
            ],
          ),
        )
    );
  }
}
