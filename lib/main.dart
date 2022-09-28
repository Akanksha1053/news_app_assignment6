import 'package:flutter/material.dart';
import 'package:news_app_assignment6/providers/provider_data.dart';
import 'package:news_app_assignment6/screens/create_new_article.dart';
import 'package:news_app_assignment6/screens/home_screen.dart';
import 'package:news_app_assignment6/screens/specific_news_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderData>(
      create: (context) => ProviderData(),
      child: MaterialApp(
        home: const HomeScreen(),
        routes: {
          CreateNewArticle.routeName: (context) => const CreateNewArticle(),
          SpecificNewsScreen.routeName: (context) => const SpecificNewsScreen(),
        },
      ),
    );
  }
}
