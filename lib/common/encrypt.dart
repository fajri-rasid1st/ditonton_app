// coverage:ignore-file

// Function to encrypt text
import 'package:encrypt/encrypt.dart';

String encrypt(String plainText) {
  final key = Key.fromLength(32);
  final iv = IV.fromLength(8);

  final encrypter = Encrypter(Salsa20(key));
  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted.base64;
}
