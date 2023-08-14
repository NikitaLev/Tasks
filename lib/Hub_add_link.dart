import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'HUB.dart';
import 'HubPage.dart';
import 'main.dart';

class Hub_add_link extends StatefulWidget {
  late HUB hub;

  Hub_add_link({super.key, required hub}) {
    this.hub = hub;
  }
  @override
  _Hub_add_link createState() => _Hub_add_link(hub: hub);
}

class _Hub_add_link extends State<Hub_add_link> {
  late HUB hub;
  late String src;
  late List<String> ttt = <String>['testtt'];
  TextEditingController controller = TextEditingController();
  late String currentDate;

  _Hub_add_link({required hub}) {
    this.hub = hub;
    //print("test --- " + hub.name);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    currentDate = now.toString();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.green,
            title: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: const Icon(
                      Icons.arrow_circle_right_outlined,
                      size: 30,
                    ),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: RichText(
                        textDirection: TextDirection.ltr,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: hub.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '\n${hub.countResources} resources',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ))),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_circle_left_outlined,
                        size: 20,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HubPage(
                                  hub: hub,
                                )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: Column(children: [
                      Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: Text("Enter link:")),
                      TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ]),
                  )),
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(children: [
                    Expanded(
                        flex: 1,
                        child: Builder(builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding: const EdgeInsets.all(16),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => main_widget()),
                                );
                              },
                              child: Row(
                                textDirection: TextDirection.ltr,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                            textDirection: TextDirection.ltr,
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Cancel',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ))),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 4, left: 5),
                                      alignment: Alignment.centerLeft,
                                      child: const Icon(
                                        Icons.cancel_outlined,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
                    Expanded(
                        flex: 1,
                        child: Builder(builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.all(16),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                _add_link();
                              },
                              child: Row(
                                textDirection: TextDirection.ltr,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                            textDirection: TextDirection.ltr,
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Add',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' Link',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ))),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 4, left: 5),
                                      alignment: Alignment.centerLeft,
                                      child: const Icon(
                                        Icons.add_circle_outline_outlined,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
                  ]),
                ),
              ),
            ],
          )),
        ));
  }

  _add_link() async {
    setState(() {
      String link = controller.text;
      hub.addLink(link);
      HUB.saveHub(hub);
    });
  }
}
