import 'package:flutter/material.dart';
import 'package:gjk_cp/view/splash_screen.dart';
import 'package:gjk_cp/view/tele_caller.dart';
import 'package:gjk_cp/viewmodel/banner_viewmodel.dart';
import 'package:gjk_cp/viewmodel/call_action_viewmodel.dart';
import 'package:gjk_cp/viewmodel/call_list_viewmodel.dart';
import 'package:gjk_cp/viewmodel/callus_viewmodel.dart';
import 'package:gjk_cp/viewmodel/cp_dashboard_viewmodel.dart';
import 'package:gjk_cp/viewmodel/feth_project_viewmodel.dart';
import 'package:gjk_cp/viewmodel/login_view_model.dart';
import 'package:gjk_cp/viewmodel/register_viewmodel.dart';
import 'package:gjk_cp/viewmodel/tele_source_viewmodel.dart';
import 'package:gjk_cp/viewmodel/tell_call_viewmodel.dart';
import 'package:gjk_cp/viewmodel/video_projects_viewmodel.dart';
import 'package:gjk_cp/viewmodel/video_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        //  ChangeNotifierProvider(
        //   create: (_) => BannerViewModel()..fetchBanners(),
        // ),
        ChangeNotifierProvider(create: (_) => BannerViewModel()),
        ChangeNotifierProvider(create: (_) => FethProjectViewmodel()),
        ChangeNotifierProvider(
          create: (_) => CallListViewmodel(),
          child: TeleCaller(title: ''),
        ),
        ChangeNotifierProvider(create: (_) => TellCallViewmodel()),
        ChangeNotifierProvider(
          create: (_) => TeleSourceViewModel(),
          child: TeleCaller(title: ""),
        ),
        ChangeNotifierProvider(create: (_) => CpDashboardViewModel()),
        ChangeNotifierProvider(create: (_) => CallActionViewModel()),
        ChangeNotifierProvider(create: (_) => CallusViewmodel()),
        ChangeNotifierProvider(create: (_) => VideoProjectsViewmodel()),
        ChangeNotifierProvider(create: (_) => VideoViewModel()),
      ],
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
