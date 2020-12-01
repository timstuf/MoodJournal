import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:mood_journal/api/api_error.dart';
import 'package:mood_journal/api/model/mood_model.dart';
import 'package:mood_journal/api/model/user_mood_model.dart';
import 'package:mood_journal/api/service/mood_picture_service.dart';
import 'package:mood_journal/api/service/user_mood_service.dart';
import 'package:mood_journal/resources/app_constants.dart';
import 'package:mood_journal/resources/strings.dart';

import 'api_error.dart';

class ApiClient {
  static final ChopperClient _chopperClient = ChopperClient(
    baseUrl: AppConstants.baseUrl,
    services: [
      MoodPictureService.create(),
      UserMoodService.create(),
    ],
    converter: JsonConverter(),
  );

  static final moodService = _chopperClient.getService<MoodPictureService>();
  static final userMoodService = _chopperClient.getService<UserMoodService>();

  Future<List<MoodModel>> getMoods() async {
    final rawMoods =
        (await _makeCheckedCall(() => moodService.getAllMoodPictures())).body
            as List<dynamic>;
    final moods =
        rawMoods.map((rawMood) => MoodModel.fromJson(rawMood)).toList();

    return moods;
  }

  Future<List<UserMoodModel>> getUserMoods(int id) async {
    final rawUserMoods =
        (await _makeCheckedCall(() => userMoodService.getUserMoods(id))).body
            as List<dynamic>;
    final moods = rawUserMoods
        .map((rawUserMood) => UserMoodModel.fromJson(rawUserMood))
        .toList();

    return moods;
  }

  Future saveUserMood(UserMoodModel moodModel) async {
    try {
      await _makeCheckedCall(
          () => userMoodService.addUserMood(moodModel.toJson()));
    } on ApiError catch (_) {
      rethrow;
    } on SocketException catch (_) {
      rethrow;
    } catch (ex) {
      rethrow;
    }
    print("POST request for task");
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
    } on SocketException catch (ex){
      throw ApiError(message: Strings.internetConnectionError);
    } catch (ex) {
      throw ApiError(message: Strings.generalErrorMessage);
    }
  }
}

