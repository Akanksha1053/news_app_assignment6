import 'package:flutter/material.dart';
import 'package:news_app_assignment6/constants/colors.dart';
import 'package:news_app_assignment6/screens/create_new_article.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: scaffoldBackgroundcolor,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(('/'));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: const Text('Add a new article'),
            onTap: () {
              Navigator.pushNamed(context, CreateNewArticle.routeName);
            },
          ),
        ],
      ),
    );
  }
}
