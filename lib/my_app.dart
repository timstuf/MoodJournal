import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mood_journal/bloc/user_block.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/ui/pages/home_page.dart';

import 'api/api_client.dart';
import 'ui/pages/user_page.dart';

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
          (i) => UserPageBloc(i.getDependency<ApiClient>()),
          singleton: false,
        ),
      ],
      dependencies: [
        Dependency((i) => ApiClient(), singleton: true),
      ],
      child: MaterialApp(
        title: Strings.appName,
        theme: ThemeData(
          primaryColor: Color(0xFF97C8EB),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: UserPage(),
      ),
    );
  }
}
