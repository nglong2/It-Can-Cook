import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class Util {
  Future<String> uploadFile(File file) async {
    final uri = Uri.parse('https://api.wemealkit.ddns.net/api/util/UploadFile');
    var request = http.MultipartRequest('POST', uri);

    // Add file to the request
    var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    var fileStream = http.ByteStream(file.openRead());
    var fileLength = await file.length();

    var multipartFile = http.MultipartFile(
      'File',
      fileStream,
      fileLength,
      filename: basename(file.path), // Get the file name
      contentType: MediaType.parse(mimeType), // Set the content type
    );

    request.files.add(multipartFile);

    // Add headers (if needed)
    request.headers.addAll({
      'accept': '*/*',
    });
    var response = await request.send();
    return response.stream.bytesToString();
  }
}
