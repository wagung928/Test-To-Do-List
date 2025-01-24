import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/customs/custom_snackbar.dart';
import 'package:pembekalan_flutter/models/login_user_model.dart';
import 'package:pembekalan_flutter/utilities/networking/networking_response.dart';
import 'package:pembekalan_flutter/utilities/networking/response_unsuccess.dart';
import 'package:pembekalan_flutter/utilities/repositories/api_repository.dart';

class LoginUserViewmodel {
  LoginUserViewmodel();

  //String? get token => null;

  Future<LoginUserModel?> postDataToAPI(
      BuildContext context, String email, String password) async {
    NetworkingResponse response =
        await APIRepository().loginUser(email, password);

    //cek apakah status code
    if (response is NetworkingSuccess) {
      if (response.statusCode == 200) {
        //proses konversi dari response jadi model
        LoginUserModel model =
            LoginUserModel.fromJson(jsonDecode(response.body.toString()));
        return model;
      } else if (response.statusCode == 200) {
        //selain code 200, silahkan handle disini akseinya apa
        print('Status Code : ${response.statusCode}');
        print('Message : ${response.body}');

        var error = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(error));
      } else {
        //selain code 200, silahkan handle disini akseinya apa
        print('Status Code : ${response.statusCode}');
        print('Message : ${response.body}');

        ResponseUnsuccess responseUnsuccess =
            responseUnsuccessFromJson(response.body.toString());
        String message = '$responseUnsuccess.message [${response.statusCode}]';
        return null;
      }
    } else if (response is NetworkingException) {
      //ada yang salah?, informasikan ke users apa problemnya
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(response.message));
      return null;
    }
    return null;
  }
}
