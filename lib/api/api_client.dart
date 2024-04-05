import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/model/login_scuccess_model.dart';

import '../constants/string_constants.dart';
import '../utility/helper_widget.dart';

class ApiClient {
  String username = "AKAAL";
  String password = "SnVuIDEwLCAyMDIy";

  Future<dynamic> getWithTokenForTracker(String url) async {
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    String userType = LocalStorage().read(key: StringConstants.userType);
    myLog(label: "user get", value: userType);
    LoginSuccessModel loginSuccessModel = await findLoginSuccessModel();
    Map<String, String> headers = {
      "Token": loginSuccessModel.data?.accessToken ?? "",
      'Authorization': basicAuth,
    };
    myLog(label: "header", value: headers.toString());
    myLog(label: "url", value: url.toString());
    myLog(label: "url", value: url);
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print(response.statusCode.toString() + "status code");
      responseJson = _response(response);
      myLog(label: "response", value: responseJson);
    } on SocketException {
      //  showToast(message:  'No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map param) async {
    log("POST-->: $url");
    log("Calling parameters: $param");
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var headers = {
      'Authorization': basicAuth,
    };
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(url), body: param, headers: headers);
      responseJson = _response(response);
      myLog(label: "response get", value: response.body.toString());
      print("Response: $responseJson");
    } catch (error) {
      log(error.toString());
    }
    return responseJson;
  }

  Future<dynamic> postMultipart(
      String url, Map<String, String> param, File files) async {
    print("POST-->: $url");
    print("Calling parameters: $param");
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var headers = {
      'Authorization': basicAuth,
    };

    var responseJson;
    try {
      final request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll(headers);
      request.fields.addAll(param);
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        await files.readAsBytes(),
      ));
      var response = await request.send();
      final respStr = await http.Response.fromStream(response);
      responseJson = await _response(respStr);
      print("Response: ${responseJson}");
    } catch (error) {
      log(error.toString());
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    print("GET-->: $url");
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var headers = {
      'Authorization': basicAuth,
    };
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print(response.statusCode.toString() + "status code");
      responseJson = _response(response);
      print("Response: $responseJson");
    } on SocketException {
      //  showToast(message:  'No Internet connection');
    }
    return responseJson;
  }

  ///---------------------with token--------------

  Future<dynamic> postWithToken(String url, var param) async {
    String userType = LocalStorage().read(key: StringConstants.userType);
    myLog(label: "user get", value: userType);
    LoginSuccessModel loginSuccessModel = await findLoginSuccessModel();
    Map<String, String> headers = {
      "AccessToken": loginSuccessModel.data?.accessToken ?? "",
    };
    myLog(label: "headers", value: headers.toString());
    myLog(label: "raw", value: param);
    myLog(label: "url", value: url);
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(url), body: param, headers: headers);
      responseJson = _response(response);
      log("Response: ${response.body}");
    } catch (error) {
      log(error.toString());
    }
    return responseJson;
  }

  Future<dynamic> postWithTokenAndEncoding(String url, var param) async {
    String userType = LocalStorage().read(key: StringConstants.userType);
    myLog(label: "user get", value: userType);
    LoginSuccessModel loginSuccessModel = await findLoginSuccessModel();
    Map<String, String> headers = {
      "AccessToken": loginSuccessModel.data?.accessToken ?? "",
      "Content-Type": "application/json"
    };
    myLog(label: "headers", value: headers.toString());
    myLog(label: "raw", value: param.toString());
    myLog(label: "url", value: url);
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(url), body: param, headers: headers);
      responseJson = _response(response);
      log("Response: ${response.body}");
    } catch (error) {
      log(error.toString());
    }
    return responseJson;
  }

  Future<dynamic> getWithToken(String url) async {
    String userType = LocalStorage().read(key: StringConstants.userType);
    myLog(label: "user get", value: userType);
    LoginSuccessModel loginSuccessModel = await findLoginSuccessModel();
    Map<String, String> headers = {
      "AccessToken": loginSuccessModel.data?.accessToken ?? "",
      "Content-Type": "application/json"
    };
    myLog(label: "header", value: headers.toString());
    myLog(label: "url", value: url.toString());
    myLog(label: "url", value: url);
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print(response.statusCode.toString() + "status code");
      responseJson = _response(response);
      myLog(label: "response", value: responseJson);
    } on SocketException {
      //  showToast(message:  'No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      case 400:
        log(response.body.toString());

        // showToast(message: jsonDecode(response.body)['message'].toString());
        return null;

      case 401:
      case 403:
        log(response.body.toString());
        // showToast(message:  jsonDecode(response.body)['message'].toString());
        return null;

      case 404:
        log(response.body.toString());
        // showToast(message:  jsonDecode(response.body)['message'].toString());
        return null;

      case 409:
        log(response.body.toString());
        //  showToast(message:  jsonDecode(response.body)['message'].toString());
        return null;

      case 408:
        log(response.body.toString());
        // showToast(message: jsonDecode(response.body)['message'].toString());
        return null;

      case 500:
        log(response.body.toString());
        // showToast(message:  jsonDecode(response.body)['message'].toString());
        return null;

      case 503:
        log(response.body.toString());
        //  showToast(message:  jsonDecode(response.body)['message'].toString());
        return null;
      default:
      // showToast(message:
      // 'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}

findLoginSuccessModel() {
  String userType = LocalStorage().read(key: StringConstants.userType);
  return LocalStorage().readModel(
      key: userType == StringConstants.parentType
          ? StringConstants.parentLoginSuccessModel
          : userType == StringConstants.teacherType
              ? StringConstants.teacherLoginSuccessModel
              : userType == StringConstants.principleType
                  ? StringConstants.principalLoginSuccessModel
                  : userType == StringConstants.receptionType
                      ? StringConstants.receptionLoginSuccessModel
                      : StringConstants.coordinatorLoginSuccessModel);
}
