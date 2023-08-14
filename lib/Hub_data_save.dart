import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HUB.dart';
import 'main.dart';

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

    if (t.isEmpty) {
      HUB.saveHub(hub_data);
    } else {
      if (t.contains(hub_data.name)) {
        return;
      } else {
        HUB.saveHub(hub_data);
      }
    }
  }
}
