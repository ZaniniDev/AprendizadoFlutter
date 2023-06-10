import 'package:encrypt/encrypt.dart';

class Criptografia {
  static String chaveCriptografia = "0434d4252b9eb8c64e73c966a43f226f";
  static Encrypted? encrypted;
  static var decrypted;

  static String criptografarTexto(String texto) {
    final key = Key.fromUtf8(chaveCriptografia);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    encrypted = encrypter.encrypt(texto, iv: iv);
    return encrypted!.base64;
  }

  static String descriptografarTexto(String encryptedText) {
    final key = Key.fromUtf8(chaveCriptografia);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    decrypted = encrypter.decrypt(encrypted!, iv: iv);
    return decrypted;
  }
}
