import 'package:flutter/material.dart';

import 'Screens/home_page.dart';

class LiveScoreApp extends StatelessWidget {
  const LiveScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live Score App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.green,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  HomePage(),
    );
  }
}