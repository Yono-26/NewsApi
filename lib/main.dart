import 'package:flutter/material.dart';
import 'package:news_app/provider/article_provider.dart';
import 'package:news_app/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context)=> ArticleProvider()),
    ],
    child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    ),
    );
  }
}
