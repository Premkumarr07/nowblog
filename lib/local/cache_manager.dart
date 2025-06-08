import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheManager {
  static Future<String> _getCacheDirPath() async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  static Future<File> _getCacheFile(String filename) async {
    final path = await _getCacheDirPath();
    return File('$path/$filename.json');
  }

  /// Save data (usually JSON) to cache file
  static Future<void> writeCache(String filename, Map<String, dynamic> data) async {
    final file = await _getCacheFile(filename);
    final jsonString = jsonEncode(data);
    await file.writeAsString(jsonString);
  }

  /// Read cached data if exists
  static Future<Map<String, dynamic>?> readCache(String filename) async {
    try {
      final file = await _getCacheFile(filename);
      if (await file.exists()) {
        final contents = await file.readAsString();
        return jsonDecode(contents) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Delete a specific cache file
  static Future<void> deleteCache(String filename) async {
    final file = await _getCacheFile(filename);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Clear all cache files
  static Future<void> clearAllCache() async {
    final path = await _getCacheDirPath();
    final dir = Directory(path);
    final files = dir.listSync();
    for (var file in files) {
      if (file is File && file.path.endsWith('.json')) {
        await file.delete();
      }
    }
  }
}
