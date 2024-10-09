

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:three/pages/home_page.dart';
import 'package:three/themes/theme_provider.dart';
import 'package:three/models/playlist_provider.dart';


void main() {
  runApp(MultiProvider(providers: [
  ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ChangeNotifierProvider(create: (context) => PlaylistProvider())],
  child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MyHomePage(),
    theme: Provider.of<ThemeProvider>(context).themeData,
    
    );
  }
}


