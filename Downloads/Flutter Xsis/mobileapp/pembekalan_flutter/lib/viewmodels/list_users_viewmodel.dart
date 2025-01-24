import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/customs/custom_snackbar.dart';
import 'package:pembekalan_flutter/models/list_users_model.dart';
import 'package:pembekalan_flutter/utilities/networking/networking_response.dart';
import 'package:pembekalan_flutter/utilities/networking/response_unsuccess.dart';
import 'package:pembekalan_flutter/utilities/repositories/api_repository.dart';

class ListUsersViewmodel {
  ListUsersViewmodel();

  Future<ListUsersModel?> getDataFromAPI(BuildContext context, int page) async {
    //connect API
    NetworkingResponse response = await APIRepository().getListUsers(page);

    if (response is NetworkingSuccess) {
      if (response.statusCode == 200) {
        //proses konversi dari response jadi model

        ListUsersModel model =
            ListUsersModel.fromJson(json.decode(response.body.toString()));
        return model;
      } else {
        //selain code 200, silahkan handle disini akseinya apa
        print('Status Code : n${response.statusCode}');
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
