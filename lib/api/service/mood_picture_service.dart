import 'package:chopper/chopper.dart';
import 'package:mood_journal/resources/app_constants.dart';

part 'mood_picture_service.chopper.dart';

@ChopperApi(baseUrl: AppConstants.moodPictureUrl)
abstract class MoodPictureService extends ChopperService {
  static MoodPictureService create([ChopperClient client]) =>
      _$MoodPictureService(client);

  @Get()
  Future<Response> getAllMoodPictures();
}
