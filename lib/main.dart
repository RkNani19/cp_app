import 'package:flutter/material.dart';
import 'package:gjk_cp/view/login_screen.dart';
import 'package:gjk_cp/view/splash_screen.dart';
import 'package:gjk_cp/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(title: 'GJKedia'),
    );
  }
}

