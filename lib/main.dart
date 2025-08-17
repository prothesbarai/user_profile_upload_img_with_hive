import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_profile_image_with_hive/pages/splash_screen/splash_screen.dart';
import 'package:user_profile_image_with_hive/provider/profile_image_provider.dart';
import 'package:user_profile_image_with_hive/service/hive_service.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.initHive();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileImageProvider()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

