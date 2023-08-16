import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:file_picker/file_picker.dart';
import 'HUB.dart';
import 'HubPage.dart';
import 'Hub_data_save.dart';

void main() {
  runApp(Container(
      color: Colors.white, alignment: Alignment.center, child: main_widget()));
}

class main_widget extends StatefulWidget {
  @override
  _main_widget createState() => _main_widget();
}

class _main_widget extends State<main_widget> {
  List<HUB> hubList = <HUB>[];
  List<String> list = <String>["test"];

  _reDrawWidget() async {
    var keys = await HUB.getSharedPreferencesKeys();
    print(keys);
    List<HUB> hub_list = <HUB>[];
    for (String key in keys) {
      var item = await HUB.getDataFromSharedPreferences(key);
      print(item);
      print(item.runtimeType);
      HUB hub = HUB.get_hub(item);
      print(hub.name); //HexColor(
      hub_list.add(hub);
    }
    update_data(hub_list);
  }

  update_data(List<HUB> hub) {
    setState(() {
      hubList = hub;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            drawer: Drawer(
                backgroundColor: Color.fromARGB(129, 150, 150, 150),
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
                        child: Builder(builder: (BuildContext context) {
                          return Container(
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: hubList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Color color = hubList[index].color;
                                  String name = hubList[index].name;
                                  String letter = name[0];
                                  String data =
                                      "${hubList[index].dateTime.day}.${hubList[index].dateTime.month}.${hubList[index].dateTime.year}";
                                  String count =
                                      hubList[index].countResources.toString();
                                  return Container(
                                      margin: EdgeInsets.only(top: 5),
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            side: BorderSide.none,
                                            backgroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => HubPage(
                                                      hub: hubList[index])),
                                            );
                                          },
                                          child: Row(children: [
                                            Expanded(
                                                flex: 1,
                                                child: Stack(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    children: <Widget>[
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          letter,
                                                          style: TextStyle(
                                                            color: color,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 1,
                                                                right: 1),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Icon(
                                                          color: color,
                                                          Icons.circle_outlined,
                                                          size: 40,
                                                        ),
                                                      ),
                                                    ])),
                                            Expanded(
                                                flex: 2,
                                                child: RichText(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: name,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              '\n$count resources',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ],
                                                    ))),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Text(data,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10,
                                                        )))),
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                                  margin: EdgeInsets.all(5),
                                                  color: Color.fromARGB(
                                                      255, 224, 224, 224),
                                                  alignment: Alignment.center,
                                                  child: const Icon(
                                                    color: Color.fromARGB(
                                                        255, 172, 172, 172),
                                                    Icons.delete_outlined,
                                                    size: 25,
                                                  ),
                                                ))
                                          ])));
                                }),
                          );
                        })),
                    Expanded(
                      flex: 2,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Hub_data_save()),
                              );
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
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' HUB',
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
                        );
                      }),
                    ),
                  ],
                )),
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg.png'), fit: BoxFit.fill)),
              child: Column(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(flex: 3, child: Container()),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
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
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                left: 8, top: 5),
                                            child: RichText(
                                                textDirection:
                                                    TextDirection.ltr,
                                                text: const TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Aram Almonai',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: '\nData Scientist',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(children: [
                            Expanded(
                                flex: 2,
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
                                          flex: 3,
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
                                          flex: 3,
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
                                                fontSize: 15,
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
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            textDirection: TextDirection.ltr,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
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
                                        _reDrawWidget();
                                        Scaffold.of(context).openDrawer();
                                      },
                                      child: Column(
                                        textDirection: TextDirection.ltr,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 3,
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
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: '\nHUB',
                                                          style: TextStyle(
                                                            color: Colors.white,
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
                                                Icons
                                                    .arrow_circle_right_outlined,
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              Expanded(
                                  flex: 2,
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
                                              child:
                                                  const Icon(Icons.add_circle),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
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
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        )),
                  ]),
            )));
  }
}
