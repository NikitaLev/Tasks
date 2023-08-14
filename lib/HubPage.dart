import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'Hub_add_link.dart';
import 'HUB.dart';
import 'main.dart';

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
    //print("test --- " + hub.name);
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
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_circle_left_outlined,
                        size: 20,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => main_widget()),
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Hub_add_link(hub: hub)));
                            },
                            child: Row(
                              textDirection: TextDirection.ltr,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
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
                                      Icons.add_link_outlined,
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
