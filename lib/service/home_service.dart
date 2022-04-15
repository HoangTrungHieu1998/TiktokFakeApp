import 'dart:convert';
import 'dart:io';

import 'package:flutter_tiktok/model/Profile.dart';
import 'package:flutter_tiktok/model/Result.dart';
import 'package:flutter_tiktok/model/User.dart';
import 'package:flutter_tiktok/service/cache_manager.dart';
import 'package:flutter_tiktok/ui/profile/bloc/profile_bloc.dart';
import 'package:flutter_tiktok/ultils/api.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomeService{
  HomeService._();

  static final HomeService instance = HomeService._();

  Future<List<User>?> getUser() async {
    try {
      var uri = Uri.parse(Api.instance.urlVideo);
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(uri,headers: headers);
      if (response.statusCode == 200) {
        Map jsonRaw = json.decode(response.body);
        List<User> _list = [];
        List<dynamic>? data = jsonRaw["data"];
        if (data != null && data.isNotEmpty) {
          for (var p in data) {
            _list.add(User.fromJson(p));
          }
        }
        return _list;
      }
    } on Exception catch (e) {
      print('~~~~~~$e');
      return [];
    }
    return [];
  }
  Future<Profile?> getProfile({int? id}) async {
    try {

      var uri = Uri.parse(Api.instance.urlProfile +'?id=$id');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(uri,headers: headers);
      if (response.statusCode == 200) {
        Map jsonRaw = json.decode(response.body);
        if(jsonRaw["data"]!=null){
          final a = Profile.fromJson(jsonRaw["data"]);
          return a;
        }else{
          return null;
        }
      }
    } on Exception catch (e) {
      print('~~~~~~$e');
      return null;
    }
    return null;
  }

  Future<Profile?> getUserVideo({int? id}) async {
    try {

      var uri = Uri.parse(Api.instance.urlProfile +'?customerId=$id');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(uri,headers: headers);
      if (response.statusCode == 200) {
        Map jsonRaw = json.decode(response.body);
        final a = Profile.fromJson(jsonRaw["data"]);
        return a;
      }
    } on Exception catch (e) {
      print('~~~~~~$e');
      return null;
    }
    return null;
  }

  Future<Results> checkLogin({String? loginName, String? loginPassword}) async {
    try {
      var object = {
        "loginName": loginName,
        "loginPassword": loginPassword
      };
      var uri = Uri.parse(Api.instance.urlCheckLogin);
      final jsonString = json.encode(object);
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.post(uri,headers: headers,body: jsonString);
      if (response.statusCode == 200) {
        Map jsonRaw = json.decode(response.body);
        CacheManager.instance.set("login", jsonRaw["data"],1440);
        return Results(data: jsonRaw["data"], error: jsonRaw["error"].toString(), access: jsonRaw["succeeded"], statusCode: 200);
      }
      return Results(statusCode: response.statusCode, access: false);
    } on Exception catch (e) {
      print('~~~~~~$e');
      return Results(access: false);
    }
  }

  Future<Results> signUp({String? loginName, String? loginPassword, String? userName, String? description}) async {
    try {
      var object = {
        "loginName": loginName,
        "loginPassword": loginPassword,
        "userName": userName,
        "description": description
      };
      var uri = Uri.parse(Api.instance.urlSignUp);
      final jsonString = json.encode(object);
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.post(uri,headers: headers,body: jsonString);
      if (response.statusCode == 200) {
        Map jsonRaw = json.decode(response.body);
        CacheManager.instance.set("login", jsonRaw["data"],1440);
        return Results(data: jsonRaw["data"], error: jsonRaw["error"].toString(), access: jsonRaw["succeeded"], statusCode: 200);
      }
      return Results(statusCode: response.statusCode, access: false);
    } on Exception catch (e) {
      print('~~~~~~$e');
      return Results(access: false);
    }
  }

  Future<Results> editProfile({int? id,String? loginName, String? userName}) async {
    try {
      var object = {
        "id": id,
        "loginName": loginName,
        "userName": userName
      };
      var uri = Uri.parse(Api.instance.urlEdit);
      final jsonString = json.encode(object);
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.post(uri,headers: headers,body: jsonString);
      if (response.statusCode == 200) {
        Map jsonRaw = json.decode(response.body);
        return Results(data: jsonRaw["data"], error: jsonRaw["error"].toString(), access: jsonRaw["succeeded"], statusCode: 200);
      }
      return Results(statusCode: response.statusCode, access: false);
    } on Exception catch (e) {
      print('~~~~~~$e');
      return Results(access: false);
    }
  }

  Future<Results> addLike({int? vidId,int? cusId}) async {
    try {
      var object = {
        "videoID": vidId,
        "customerID": cusId
      };
      var uri = Uri.parse(Api.instance.urlAddLike);
      final jsonString = json.encode(object);
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.post(uri,headers: headers,body: jsonString);
      if (response.statusCode == 200) {
        Map jsonRaw = json.decode(response.body);
        return Results(data: jsonRaw["data"], error: jsonRaw["error"].toString(), access: jsonRaw["succeeded"], statusCode: 200);
      }
      return Results(statusCode: response.statusCode, access: false);
    } on Exception catch (e) {
      print('~~~~~~$e');
      return Results(access: false);
    }
  }

  Future<Results> disLike({int? vidId,int? cusId}) async {
    try {
      var object = {
        "videoID": vidId,
        "customerID": cusId
      };
      var uri = Uri.parse(Api.instance.urlDisLike);
      final jsonString = json.encode(object);
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.post(uri,headers: headers,body: jsonString);
      if (response.statusCode == 200) {
        Map jsonRaw = json.decode(response.body);
        return Results(data: jsonRaw["data"], error: jsonRaw["error"].toString(), access: jsonRaw["succeeded"], statusCode: 200);
      }
      return Results(statusCode: response.statusCode, access: false);
    } on Exception catch (e) {
      print('~~~~~~$e');
      return Results(access: false);
    }
  }

  Future<Results> saveVideo({String? videoUrl,String? caption,String? songName, int? cusId}) async {
    try {
      var object = {
        "videoUrl": videoUrl,
        "caption": caption,
        "songName": songName,
        "customerId": cusId
      };
      var uri = Uri.parse(Api.instance.urlSaveVideo);
      final jsonString = json.encode(object);
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Charset': 'utf-8'
      };
      final response = await http.post(uri,headers: headers,body: jsonString);
      if (response.statusCode == 200) {
        try{
          Map jsonRaw = json.decode(response.body);
          return Results(data: jsonRaw["data"], error: jsonRaw["error"].toString(), access: jsonRaw["succeeded"], statusCode: 200);
        }catch(e){
          print("error: $e");
        }
      }
      return Results(statusCode: response.statusCode, access: false);
    } on Exception catch (e) {
      print('~~~~~~$e');
      return Results(access: false);
    }
  }

  Future<Results> uploadVideo({String? filename}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(Api.instance.urlUploadVideo));
      request.files.add(await http.MultipartFile.fromPath('file',filename!));
      StreamedResponse res = await request.send();
      if (res.statusCode == 200) {
        Map? jsonRaw = json.decode(await res.stream.bytesToString());
        if (jsonRaw != null) {
          print(jsonRaw["data"].toString());
          return Results(statusCode: 200, data: jsonRaw["data"], error: jsonRaw["error"], access: jsonRaw["succeeded"]);
        }
      } else {
        return Results(access: false);
      }
    } on Exception catch (_) {
      print('error Call configureApp ${_.toString()}');
      return Results(access: false);
    }

    return Results(access: false);
  }

}