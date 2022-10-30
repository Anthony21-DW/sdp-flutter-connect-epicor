import 'dart:convert';

import 'package:flutter_fix_sdp/models/response_api.dart';
import 'package:get/get.dart';

class LoginService extends GetConnect {
  Future<dynamic> login(Map<dynamic, dynamic> data) async {
    String url =
        "https://www.erp.intalogi.com/kinetic-presales/api/v1/BaqSvc/AH_TodoUD9_Test/";
    var header = {
      'authorization':
          'Basic ${base64Encode(utf8.encode('${data['username']}:${data['password']}'))}',
      "Accept": "application/json"
    };

    try {
      ResponseApi response = ResponseApi(code: 0, status: "");
      Response res = await get(url, headers: header);
      if (res.statusCode == 200) {
        response.status = res.statusText ?? "OK";
      } else {
        response.status = res.statusText ?? "Not OK";
      }
      response.code = res.statusCode!;
      return response;
    } catch (e) {
      ResponseApi response = ResponseApi(code: 0, status: e.toString());
      return response;
    }
  }
}
