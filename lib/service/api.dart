import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:kozarni_ecome/data/constant.dart';

import '../data/api/api.dart';
import '../routes/routes.dart';

class Api {
  final dio.Dio _dio = dio.Dio();

  Future<void> uploadFile(
    String filePath, {
    String folder = 'items/',
    String? fileName,
  }) async {
    final dio.MultipartFile _file = await dio.MultipartFile.fromFile(
      filePath,
      filename: fileName,
    );
    try {
      await _dio.post(
        "$baseUrl$folder",
        data: dio.FormData.fromMap(
          {
            'file': _file,
          },
        ),
      );
    } catch (e) {
      print("file upload error is $e");
    }
  }

   
  //Send Notificaiton After order uploaded
  static Future<void> sendPush(String title, String message) async {
    //final token = await FirebaseMessaging.instance.getToken();
    final jsonBody = <String, dynamic>{
      "notification": <String, dynamic>{
        "title": title,
        "body": message,
      },
      "data": <String, dynamic>{
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "route": purchaseScreen,
      },
      "condition": "'order' in topics",
    };
    await Dio().post("https://fcm.googleapis.com/fcm/send",
        data: jsonBody,
        options: Options(headers: {
          "Authorization": "key=$fcmKey",
          "Content-Type": "application/json"
        }));
  }
}
