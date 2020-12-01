import 'package:chopper/chopper.dart';
import 'package:mood_journal/resources/app_constants.dart';

part 'user_mood_service.chopper.dart';

@ChopperApi(baseUrl: AppConstants.userMoodUrl)
abstract class UserMoodService extends ChopperService {
  static UserMoodService create([ChopperClient client]) => _$UserMoodService(client);

  @Get(path: '/{id}')
  Future<Response> getUserMoods(@Path() int id);

  @Post()
  Future<Response> addUserMood(@Body() Map<String, dynamic> userMood);

}