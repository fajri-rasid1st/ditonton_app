import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.absolute.path;

  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }

  return File('$dir/test/$name').readAsStringSync();
}
