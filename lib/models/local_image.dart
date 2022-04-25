import 'dart:async';
import 'dart:io' as Io;
import 'package:image/image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
class SaveFile {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  Future<Io.File> getImageFromNetwork(String url) async {

    final cache =  DefaultCacheManager();
    final file = await cache.getSingleFile(url);
    return file;
  }

  Future<String> saveImage({String url, int id }) async {

    final file = await getImageFromNetwork(url);
    //retrieve local path for device
    var path = await _localPath;
    Image image = decodeImage(file.readAsBytesSync());

    // Image thumbnail = copyResize(image, width: 200,height: 400);

    // Save the thumbnail as a PNG.
    new Io.File('$path/"$id"+".png"')
      ..writeAsBytesSync(encodePng(image));
    return '$path/"$id"+".png"';
  }
}