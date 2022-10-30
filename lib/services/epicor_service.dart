import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import '../models/epicor_model.dart';
import 'dart:convert';

import '../models/response_api.dart';

class EpicorService extends GetConnect {
  List<EpicorModel> listModel = <EpicorModel>[];
  ResponseApi response = ResponseApi(code: 0, status: "", data: null);
  String url =
      "https://www.erp.intalogi.com/kinetic-presales/api/v1/BaqSvc/AH_TodoUD9_Test/";
  var header = {
    'authorization': 'Basic ${base64Encode(utf8.encode('manager:manager'))}',
    "Accept": "application/json"
  };
  var body = {
    "UD09_Character01": "",
    "UD09_CheckBox01": false,
    "UD09_Company": "EPIC06",
    "UD09_Key1": "",
    "UD09_Key2": "k",
    "UD09_Key3": "k",
    "UD09_Key4": "k",
    "UD09_Key5": "k",
    "RowMod": "",
    "SysRowID": "00000000-0000-0000-0000-000000000000",
    "RowIdent": "00000000-0000-0000-0000-000000000000"
  };

  //get list from epicor
  Future<dynamic> getList() async {
    try {
      Response res = await get(url, headers: header);
      if (res.statusCode == 200) {
        response.status = res.statusText ?? "OK";
        var data = res.body['value'];
        print(data[0]['UD09_Character01']);
        for (var val in data) {
          EpicorModel model = EpicorModel(id: "");
          model.id = val['UD09_Key1'];
          model.isDone = val['UD09_CheckBox01'];
          model.textInput = val['UD09_Character01'];
          listModel.add(model);
        }
        response.data = listModel;
      } else {
        response.status = res.statusText ?? "OK";
        response.data = null;
      }
      response.code = res.statusCode!;
      return response;
    } catch (e) {
      response.code = 0;
      response.status = e.toString();
      return response;
    }
  }

  Future<dynamic> add(EpicorModel model) async {
    try {
      var data = body;
      data["UD09_Character01"] = model.textInput.toString();
      data["RowMod"] = "A";
      data["UD09_Key1"] = model.id;

      Response res = await patch(url, data, headers: header);
      if (res.statusCode == 200) {
        response.status = res.statusText ?? "OK";
      } else {
        response.status = res.statusText ?? "Not OK";
      }
      response.code = res.statusCode!;
      return response;
    } catch (e) {
      response.status = e.toString();
      return response;
    }
  }

  Future<dynamic> deleteData(String id) async {
    String delUrl =
        "https://www.erp.intalogi.com/kinetic-presales/api/v1/Ice.BO.UD09Svc/UD09s(EPIC06,${id},k,k,k,k)";
    Response res = await delete(delUrl, headers: header);
    if (res.statusCode == 204) {
      response.code = 200;
      response.status = res.statusText ?? "OK";
    } else {
      response.code = res.statusCode!;
      response.status = res.statusText ?? "Not Ok";
    }
    return response;
  }

  dynamic updateIsDone(EpicorModel model) async {
    var data = body;
    data["UD09_Key1"] = model.id;
    data["UD09_CheckBox01"] = model.isDone;
    data["RowMod"] = "A";
    data["UD09_Character01"] = model.textInput.toString();

    try {
      Response res = await patch(url, data, headers: header);
      if (res.statusCode == 200) {
        response.status = res.statusText ?? "OK";
      } else {
        response.status = res.statusText ?? "Not OK";
      }
      response.code = res.statusCode!;
      return response;
    } catch (e) {
      response.status = e.toString();
      return response;
    }
  }
}
