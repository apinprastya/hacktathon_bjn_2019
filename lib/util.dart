import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class Util {
  static Future<String> uploadFile(String path,
      {ProgressCallback onSendProgress}) async {
    final mim = lookupMimeType(path).split("/");
    final fData = FormData.fromMap({
      'file': await MultipartFile.fromFile(path,
          contentType: MediaType(mim[0], mim[1])),
    });
    try {
      final res = await Dio().post(
          'https://purwosari.desaapi.lekapin.com/upload',
          data: fData,
          onSendProgress: onSendProgress);
      return res.data['url'];
    } catch (e) {
      throw e;
    }
  }
}
