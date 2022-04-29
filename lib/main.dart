import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_gain/app_cubit/app_cubit.dart';
import 'package:movie_gain/core/dio_helper.dart';
import 'package:movie_gain/core/show_toast.dart';
import 'package:movie_gain/core/widgets.dart';
import 'package:movie_gain/screens/splash.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

Future<void> firebaseMessagingBackGroundHandler(RemoteMessage message) async {
  debugPrint('onBackgroundMessage ' + message.data.toString());
  showToast(text: 'onBackgroundMessage', state: ToastStates.success);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  token = (await FirebaseMessaging.instance.getToken())!;

  FirebaseMessaging.onMessage.listen((event) {
    debugPrint('onMessage event.data ' + event.data.toString());
    showToast(text: 'onMessage', state: ToastStates.success);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    debugPrint('onMessageOpenedApp  event.data ' + event.data.toString());
    showToast(text: 'onMessageOpenedApp', state: ToastStates.success);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackGroundHandler);

  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getHomeData(),
      child: MaterialApp(
          builder: (context, child) => ResponsiveWrapper.builder(child,
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(450, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              ],
              background: Container(color: const Color(0xFFF5F5F5))),
          title: 'MovieGain',
          debugShowCheckedModeBanner: false,
          home: const SplashScreen()),
    );
  }
}
