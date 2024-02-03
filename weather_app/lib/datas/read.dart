import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/country_info.txt');
}

Future<List<Map<String, dynamic>>> readCitiesFromTextFile() async {
  try {
    final file = await _localFile;
    final lines = await file.readAsLines(encoding: utf8);

    List<Map<String, dynamic>> cities = [];

    for (final line in lines) {
      final parts = line.split(',');
      if (parts.length == 4) {
        final city = {
          'name': parts[3],
          'latitude': double.tryParse(parts[1]),
          'longitude': double.tryParse(parts[2]),
        };
        cities.add(city);
      }
    }

    return cities;
  } catch (e) {
    print('Error reading file: $e');
    return [];
  }
}
