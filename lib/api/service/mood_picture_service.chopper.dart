// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_picture_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$MoodPictureService extends MoodPictureService {
  _$MoodPictureService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = MoodPictureService;

  Future<Response> getAllMoodPictures() {
    final $url = '/moodPicture';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
