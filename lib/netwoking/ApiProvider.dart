import 'package:doctor_appointment_booking/model/backup_email_provider.dart';
import 'package:doctor_appointment_booking/model/update_model.dart';
import 'package:doctor_appointment_booking/utils/common_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

import 'CustomException.dart';

class ApiProvider {
  final String _baseUrl = "http://qrknow.co/backend/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url,var bodyData) async {
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url,body: bodyData);
      responseJson = _response(response);
      print("RES====>${response.body}");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  uploadImage(File imageFile,url,String name,String email,String mobile,BuildContext context) async {
    CommonMethod.showLoaderDialog(context, "Uploading profile");
    print("helllloooo1");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(imageFile!=null)
      {
        print("helllloooo2");
        // open a bytestream
        var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
        // get file length
        var length = await imageFile.length();

        try
        {

          var uri = Uri.parse(_baseUrl+url);

          // create multipart request
          var request = new http.MultipartRequest("POST", uri);
          request.fields["name"]=  name;
          request.fields["email"]=  email;
          request.fields["mobile"]=  mobile;
          request.fields["userId"]=  prefs.getString("id");

          // multipart that takes file
          var multipartFile = new http.MultipartFile('profile_pic', stream, length,
              filename: basename(imageFile.path));

          // add file to multipart
          request.files.add(multipartFile);

          // send
          var response = await request.send();
          print("IMAGE UPLOAD RES ==>${response.statusCode}  ${request.fields} ${request.files}");

          // listen for response
          response.stream.transform(utf8.decoder).listen((value) {
            CommonMethod.dismissDialog(context);
            //CommonMethod.showToast(context, "Profile updated successfully");
            UpdateModel model = UpdateModel.fromJson(json.decode(value));
            if(model.success==1)
            {
              CommonMethod.showToast(context, model.msg);
              CommonMethod.setPreference(context, "profile", model.data.profilePic);
              var transactionType = Provider.of<EmailProvider>(context, listen: false);
              transactionType.setProfileImage(model.data.profilePic);
              CommonMethod.setPreference(context, "name", model.data.name);
              CommonMethod.setPreference(context, "mobile", model.data.mobile);
              CommonMethod.setPreference(context, "email", model.data.email);
            }
            else{
              print("helllloooo");
              CommonMethod.showToast(context, model.msg);
              print("helllloooo");
            }
            print(" IMAGE ==>$value");
          });


        } on SocketException{
          print("helllloooo222222222");
        }
      }
    else
      {
        print("helllloooo3");
       /* // open a bytestream
        var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
        // get file length
        var length = await imageFile.length();*/

        try
        {
          print("helllloooo4");
          var uri = Uri.parse(_baseUrl+url);

          // create multipart request
          var request = new http.MultipartRequest("POST", uri);
          request.fields["name"]=  name;
          request.fields["email"]=  email;
          request.fields["mobile"]=  mobile;
          request.fields["userId"]=  prefs.getString("id");

         /* // multipart that takes file
          var multipartFile = new http.MultipartFile('profile_pic', stream, length,
              filename: basename(imageFile.path));

          // add file to multipart
          request.files.add(multipartFile);*/

          // send
          print("helllloooo444");
          var response = await request.send();
          print("IMAGE UPLOAD RES ==>${response.statusCode}  ${request.fields} ${request.files}");
          print("helllloooo5");
          // listen for response
          response.stream.transform(utf8.decoder).listen((value) {
            print("helllloooo555");
            CommonMethod.dismissDialog(context);
            //CommonMethod.showToast(context, "Profile updated successfully");
            UpdateModel model = UpdateModel.fromJson(json.decode(value));
            if(model.success==1)
            {
              CommonMethod.showToast(context, model.msg);
              CommonMethod.setPreference(context, "profile", model.data.profilePic);
              var transactionType = Provider.of<EmailProvider>(context, listen: false);
              transactionType.setProfileImage(model.data.profilePic);
              CommonMethod.setPreference(context, "name", model.data.name);
              CommonMethod.setPreference(context, "mobile", model.data.mobile);
              CommonMethod.setPreference(context, "email", model.data.email);
            }
            else{
              CommonMethod.showToast(context, model.msg);

            }
            print(" IMAGE ==>$value");
          }).onError((handleError){
            print("handleError===>>>$handleError");
          });


        } on SocketException{
          print("helllloooo5");
        }
      }

    // string to uri

  }
  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}