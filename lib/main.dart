import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:lwmt/screens/home.dart';

void main(List<String> args) async {
  if (args.contains("reset_local_spend")) {
    await Hive.deleteBoxFromDisk('spending_data');
  }
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'lwmt',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.white,
          onPrimary: Colors.black,
          secondary: Colors.white.withValues(alpha: 0.5),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.black,
          onSurface: Colors.white,
        ),
        // textTheme: ThemeData.dark().textTheme,
        useMaterial3: true,
        fontFamily: 'GoogleSansFlex',
      ),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  routes: [GoRoute(path: "/", builder: (context, state) => Home())],
);
