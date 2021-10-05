import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:socialmidia/domain/usecases/usecases.dart';
import 'infra/infra.dart';
import 'main/factories/factories.dart';
import 'main/factories/pages/pages.dart';
import 'main/factories/usecases/usecases.dart';
import 'presentation/presenters/presenter.dart';
import 'ui/components/components.dart';
import 'ui/pages/pages.dart';
import 'package:http/http.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Socialmedia',
      theme: AppTheme.lightThemeData,
      darkTheme: AppTheme.darkThemeData,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => makeLoginPage(),
        '/home': (context) => HomePage(
              presenter: GetxHomePresenter(
                addUser: makeRemoteAddUser(),
                firebaseAuthentication: makeFirebaseAuthenticationAdapter(),
                loadPeople: RemoteLoadPeople(
                  httpClient: HttpAdapter(client: Client()),
                  url: 'https://6140bdba357db50017b3d87d.mockapi.io/people',
                ),
                loadUsers: makeRemoteLoadUsers(),
              ),
            ),
        //'/profile': (context) => ProfilePage(
        //      presenter: StreamProfilePresenter(),
        //     ),
      },
    );
  }
}
