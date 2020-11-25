import 'package:chopper/chopper.dart';
import 'package:mood_journal/resources/app_constants.dart';

part 'user_service.chopper.dart';

@ChopperApi(baseUrl: AppConstants.userUrl)
abstract class UserService extends ChopperService {
  static UserService create([ChopperClient client]) => _$UserService(client);

  @Get()
  Future<Response> getAllUsers();

  @Post(path: "/add")
  Future<Response> addUser(@Body() Map<String, dynamic> user);
}