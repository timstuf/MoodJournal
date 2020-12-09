import 'package:chopper/chopper.dart';
import 'package:mood_journal/resources/app_constants.dart';

part 'user_service.chopper.dart';

@ChopperApi(baseUrl: AppConstants.userUrl)
abstract class UserService extends ChopperService {
  static UserService create([ChopperClient client]) => _$UserService(client);

  @Post(path: '/register')
  Future<Response> registerUser(@Body() Map<String, dynamic> user);

  @Post()
  Future<Response> isUser(@Body() Map<String, dynamic> user);
}
