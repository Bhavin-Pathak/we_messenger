import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_bite/design/theme.dart';
import 'package:we_bite/firebase/firebase_options.dart';
import 'package:we_bite/utils/constant/strings.dart';
import './models/user.dart' as app;
import 'screens/home/screens/home_screen.dart';
import 'screens/landing/landing_screen.dart';
import 'screens/sender_info/controllers/sender_user_data_controller.dart';
import 'utils/errors/errorscreen.dart';
import 'utils/errors/loadingscreen.dart';
import 'utils/providers/current_userprovider.dart';
import 'utils/routes/page_routes.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringsConsts.appName,
      theme: appTheme,
      home: _getHomeWidget(ref),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }

  Widget _getHomeWidget(WidgetRef ref) {
    return ref.watch(senderUserDataAuthProvider).when<Widget>(
          data: (app.User? user) {
            if (user == null) return const LandingScreen();
            currentUserProvider ??= Provider((ref) => user);
            return const HomeScreen();
          },
          error: (error, stackTrace) => ErrorScreen(
            error: error.toString(),
          ),
          loading: () => const LoadingScreen(),
        );
  }
}
