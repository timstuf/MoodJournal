import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:mood_journal/api/model/user_model.dart';
import 'package:mood_journal/api/service/user_service.dart';
import 'package:mood_journal/resources/app_constants.dart';
import 'package:mood_journal/resources/strings.dart';

import 'api_error.dart';

class ApiClient {
  static final ChopperClient _chopperClient = ChopperClient(
    baseUrl: AppConstants.baseUrl,
    services: [
      UserService.create(),
    ],
    converter: JsonConverter(),
  );

  static final userService = _chopperClient.getService<UserService>();

  Future<List<UserModel>> getUsers() async {
    final rawUsers = (await _makeCheckedCall(() => userService.getAllUsers()))
        .body as List<dynamic>;
    final users =
        rawUsers.map((rawUser) => UserModel.fromJson(rawUser)).toList();

    return users;
  }

  Future addUser(UserModel userModel) async {
    await _makeCheckedCall(() => userService.addUser(userModel.toJson()));
  }

  Future<Response> _makeCheckedCall(Future<Response> Function() call) async {
    try {
      final response = await call();

      if (response.statusCode >= 400) {
        throw ApiError(
          statusCode: response.statusCode,
          message: response.error.toString(),
        );
      }

      return response;
    } on ApiError catch (ex) {
      throw ex;
    } on SocketException {
      throw ApiError(message: Strings.internetConnectionError);
    } catch (ex) {
      throw ApiError(message: Strings.generalErrorMessage);
    }
  }
}
