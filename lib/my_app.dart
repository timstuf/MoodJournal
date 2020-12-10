import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mood_journal/bloc/mood_bloc.dart';
import 'package:mood_journal/bloc/user_mood_bloc.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/resources/utils.dart';
import 'package:mood_journal/ui/pages/welcome_page.dart';

import 'api/api_client.dart';
import 'bloc/user_bloc.dart';

class MyApp extends StatelessWidget {
  void _restrictRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _restrictRotation();
    return BlocProvider(
      blocs: [
        Bloc(
          (i) => MoodPageBloc(apiClient: i.getDependency<ApiClient>()),
          singleton: false,
        ),
        Bloc(
          (i) => UserMoodPageBloc(apiClient: i.getDependency<ApiClient>()),
          singleton: false,
        ),
        Bloc(
          (i) => UserPageBloc(apiClient: i.getDependency<ApiClient>()),
          singleton: false,
        ),
      ],
      dependencies: [
        Dependency((i) => ApiClient(), singleton: true),
      ],
      child: MaterialApp(
        title: Strings.appName,
        theme: ThemeData(
          primaryColor: Utils.getMainColor(),
          accentColor: Color(0xFF37000A),
          highlightColor:  Color(0xFFB75D69),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: WelcomePage(),
      ),
    );
  }
}
