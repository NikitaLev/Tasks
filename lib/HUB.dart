import 'dart:convert';
import 'dart:ui';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

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
    uploadFile(File(file.toString()));
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

  Future<String> uploadFile(File file) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:5000/upload'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var response = await request.send();
    if (response.statusCode == 200) {
      return 'File uploaded successfully!';
    } else {
      return 'Failed to upload file.';
    }
  }

  static Future<File> downloadFile(String filename) async {
    var response =
        await http.get(Uri.parse('http://127.0.0.1:5000/download/$filename'));
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      var filePath = join(dir.path, filename);
      var file = File(filePath);
      print(file);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to download file.');
    }
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
