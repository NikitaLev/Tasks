import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/gestures.dart';
import 'package:file_picker/file_picker.dart';

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
                                            builder: (context) =>
                                                HubPage(hub: hubList[index])),
                                      );
                                    },
                                    child: Row(children: [
                                      Expanded(
                                          flex: 1,
                                          child: Stack(
                                              textDirection: TextDirection.ltr,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.center,
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
                                                      const EdgeInsets.only(
                                                          top: 1, right: 1),
                                                  alignment: Alignment.center,
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
                                              textDirection: TextDirection.ltr,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: name,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: '\n$count resources',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ))),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              margin: EdgeInsets.only(top: 5),
                                              alignment: Alignment.topCenter,
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
                                    _reDrawWidget();
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
  late List<String> files = <String>[];
  late List<String> links = <String>[];
  HUB({
    required this.name,
    required this.dateTime,
    required this.color,
    required this.countResources,
    required this.files,
    required this.links,
  });
  void addRes() {
    countResources++;
  }

  void dellRes() {
    countResources--;
  }

  void addFile(dynamic file) {
    addRes();
    files.add(file.toString());
  }

  void removeFile(dynamic file) {
    dellRes();
    files.remove(file.toString());
  }

  void addLink(dynamic link) {
    addRes();
    links.add(link.toString());
  }

  void removeLink(dynamic link) {
    dellRes();
    links.remove(link.toString());
  }

  static void saveHub(HUB hub) async {
    Map<String, dynamic> json = {
      'name': hub.name,
      'dateTime': hub.dateTime.toString(),
      'color': hub.color.toString(),
      'countResources': hub.countResources,
      'files': hub.files,
      'links': hub.links,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(hub.name, jsonEncode(json));
  }

  static Future<dynamic> getDataFromSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString(key);
    return jsonDecode(json.toString());
  }

  static Future<List<String>> getSharedPreferencesKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().toList();
  }

  static HUB get_hub(Map<String, dynamic> hub) {
    Color color =
        Color(int.parse(hub["color"].split('(0x')[1].split(')')[0], radix: 16));
    HUB hub_data = HUB(
        name: hub["name"],
        dateTime: DateTime.parse(hub["dateTime"]),
        color: color,
        countResources: hub["countResources"],
        files: List<String>.from(hub["files"] as List),
        links: List<String>.from(hub["links"] as List));
    return hub_data;
  }
}

class Hub_data_save extends StatefulWidget {
  @override
  _Hub_data_save createState() => _Hub_data_save();
}

class _Hub_data_save extends State<Hub_data_save> {
  TextEditingController controller = TextEditingController();
  late String currentDate;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    currentDate = now.toString();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Create new HUB',
            ),
            backgroundColor: Colors.green,
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
                          child: Text("Name HUB:")),
                      TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        alignment: Alignment.topRight,
                        child: RichText(
                            textDirection: TextDirection.ltr,
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Date - ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: currentDate,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )),
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
                                                  text: 'Cansel',
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
                                _create_HUB_Data();
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

  void _create_HUB_Data() async {
    List<Color> colors = Colors.primaries;
    Random random = Random();
    Color randomColor = colors[random.nextInt(colors.length)];
    HUB hub_data = HUB(
        name: controller.text,
        dateTime: DateTime.parse(currentDate),
        color: randomColor,
        countResources: 0,
        files: <String>[],
        links: <String>[]);
    List<String> t = await HUB.getSharedPreferencesKeys();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(t.isEmpty);

    //prefs.remove("test");
    //prefs.remove("test2");
    if (t.isEmpty) {
      HUB.saveHub(hub_data);
    } else {
      if (t.contains(hub_data.name)) {
        return;
      } else {
        HUB.saveHub(hub_data);
        //print(t);
        //String? test = prefs.getString(t.last);
        //print(test);
      }
    }
    //print(t.last.runtimeType);
    //print(t.last.toString().runtimeType);
    //var tt = t.last.toString();
    //List<String>? json = prefs.remove("myList");
    //print(json);
  }
}

class HubPage extends StatefulWidget {
  late HUB hub;

  HubPage({super.key, required hub}) {
    this.hub = hub;
  }
  @override
  _HubPage createState() => _HubPage(hub: hub);
}

class _HubPage extends State<HubPage> {
  late HUB hub;
  late String src;
  late List<String> ttt = <String>['testtt'];
  _HubPage({required hub}) {
    this.hub = hub;
    print("test --- " + hub.name);
  }
  @override
  Widget build(BuildContext context) {
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
                    child: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 20,
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
                          margin: EdgeInsets.only(
                            left: 10,
                            top: 5,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text("Your files: ",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ))),
                      Container(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: hub.files.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 15, top: 10, bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Row(children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.bottomLeft,
                                        child: const Icon(
                                          Icons.description_outlined,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 8,
                                        child: RichText(
                                            textDirection: TextDirection.ltr,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: hub.files[index],
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '\n11.08.2023',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 8,
                                                  ),
                                                ),
                                              ],
                                            ))),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 5),
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
                                  ]),
                                );
                              })),
                      Container(
                          margin: EdgeInsets.only(
                            left: 10,
                            top: 10,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text("Your links: ",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ))),
                      Container(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: hub.links.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.all(10),
                                child: RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: hub.links[index],
                                        //'https://fonts.google.com/icons?selected=Material+Icons+Outlined:description:&icon.query=doc&icon.platform=flutter&icon.style=Outlined&icon.set=Material+Icons',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                          fontSize: 10,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Действия при нажатии на ссылку
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ]),
                  )),
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(children: [
                    Expanded(
                        flex: 1,
                        child: Container(
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
                            onPressed: () {},
                            child: Row(
                              textDirection: TextDirection.ltr,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 5,
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
                                  flex: 2,
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
                        )),
                    Expanded(
                        flex: 1,
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
                              _selectFile();
                            },
                            child: Row(
                              textDirection: TextDirection.ltr,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                text: ' File',
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
                                      Icons.description_outlined,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ]),
                ),
              ),
            ],
          )),
        ));
  }

  _selectFile() async {
    print("1111111111111");
    FilePickerResult? directory = await FilePicker.platform.pickFiles();
    if (directory != null) {
      setState(() {
        src = directory.files.single.path.toString();
        hub.addFile(src);
        HUB.saveHub(hub);
      });
    }
  }
}
