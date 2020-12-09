// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mood_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$UserMoodService extends UserMoodService {
  _$UserMoodService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = UserMoodService;

  Future<Response> getUserMoods(int id) {
    final $url = '/userMood/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> addUserMood(Map<String, dynamic> userMood) {
    final $url = '/userMood';
    final $body = userMood;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> editUserMood(Map<String, dynamic> userMood, int id) {
    final $url = '/userMood/${id}';
    final $body = userMood;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
