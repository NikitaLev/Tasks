import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(Container(
      color: Colors.white, alignment: Alignment.center, child: main_widget()));
}

class main_widget extends StatefulWidget {
  @override
  _main_widget createState() => _main_widget();
}

class _main_widget extends State<main_widget> {
  List<HUB> fileList = <HUB>[];
  List<String> list = <String>["test"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: Drawer(
              child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 25,
                            ),
                          )),
                      Expanded(
                          flex: 12,
                          child: Container(
                            padding: const EdgeInsets.only(left: 40),
                            alignment: Alignment.centerLeft,
                            child: RichText(
                                textDirection: TextDirection.ltr,
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'KNOWLEDGE',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\nHUB',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )),
                          )),
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.topLeft,
                            child: const Icon(
                              Icons.cancel_outlined,
                              size: 25,
                            ),
                          ))
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment.topCenter,
                    child: const Divider(
                      // Горизонтальная полоса
                      color: Color.fromARGB(255, 95, 79, 79),
                      thickness: 1,
                      height: 1,
                      indent: 10,
                      endIndent: 10,
                    )),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: Row(children: [
                              Expanded(
                                  flex: 1,
                                  child: Stack(
                                      textDirection: TextDirection.ltr,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "T",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(top: 1, right: 1),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            color: Colors.red,
                                            Icons.circle_outlined,
                                            size: 40,
                                          ),
                                        ),
                                      ])),
                              Expanded(
                                  flex: 3,
                                  child: RichText(
                                      textDirection: TextDirection.ltr,
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'MEDICINE',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '\n20 resources',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ))),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      alignment: Alignment.topCenter,
                                      child: Text("14.08.2023",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                          )))),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    color: Color.fromARGB(255, 224, 224, 224),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      color: Color.fromARGB(255, 172, 172, 172),
                                      Icons.delete_outlined,
                                      size: 25,
                                    ),
                                  ))
                            ]));
                      }),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
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
                      Scaffold.of(context).openDrawer();
                    },
                    child: Column(
                      textDirection: TextDirection.ltr,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topRight,
                            child: const Icon(
                              Icons.add_circle,
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.bottomLeft,
                              child: RichText(
                                  textDirection: TextDirection.ltr,
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'NEW',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' HUB',
                                        style: TextStyle(
                                          color: Colors.black,
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
                            alignment: Alignment.bottomLeft,
                            child: const Icon(
                              Icons.storage_outlined,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
          body: Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        textDirection: TextDirection.ltr,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.bottomLeft,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  padding: const EdgeInsets.all(16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Column(
                                  textDirection: TextDirection.ltr,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: const Text(
                                        'Profile:',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        child: RichText(
                                            textDirection: TextDirection.ltr,
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Aram Almonai',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '\nData Scientist',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ))),
                                    Container()
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Builder(builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.all(10),
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
                                    Scaffold.of(context).openDrawer();
                                  },
                                  child: Column(
                                    textDirection: TextDirection.ltr,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 9,
                                        child: Container(
                                            alignment: Alignment.bottomLeft,
                                            child: RichText(
                                                textDirection:
                                                    TextDirection.ltr,
                                                text: const TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'KNOWLEDGE',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: '\nHUB',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ))),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          child: const Icon(
                                            Icons.arrow_circle_right_outlined,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.bottomLeft,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.all(16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Column(
                                  textDirection: TextDirection.ltr,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        child: const Icon(Icons.add_circle),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.bottomLeft,
                                        child: const Text(
                                          'New Chat',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.bottomLeft,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  padding: const EdgeInsets.all(16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Column(
                                  textDirection: TextDirection.ltr,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        child: const Icon(
                                          Icons.add_circle,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 6),
                                        alignment: Alignment.bottomLeft,
                                        child: const Text(
                                          'Chat History',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.bottomLeft,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.all(16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Column(
                                  textDirection: TextDirection.ltr,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        child: const Icon(Icons.add_circle),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.file_upload_outlined,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.bottomLeft,
                                        child: const Text(
                                          'Upload Knowledge',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ]),
                    )),
              ]),
        ));
  }
}

class HUB {
  late String name;
  late DateTime dateTime;
  late Color color;
  late int countResources = 0;
  late List<File> files = <File>[];
  late List<String> links = <String>[];
}

class Hub_data_save extends StatefulWidget {
  @override
  _Hub_data_save createState() => _Hub_data_save();
}

class _Hub_data_save extends State<Hub_data_save> {
  late HUB hub;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Navigation Drawer',
            ),
            backgroundColor: const Color(0xff764abc),
          ),
        ));
  }
}
