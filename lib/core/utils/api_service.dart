import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<Response> post(
      {required body,
      required String url,
      required String token,
      Map<String, dynamic>? headers,
      String? contentType}) async {
    var responce = await dio.post(url,
        data: body,
        options: Options(
            headers: headers ??
                {
                  "Authorization": "Bearer $token",
                },
            contentType: contentType));

    return responce;
  }
}
