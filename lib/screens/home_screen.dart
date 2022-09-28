import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_assignment6/constants/colors.dart';
import 'package:news_app_assignment6/constants/strings.dart';
import 'package:news_app_assignment6/constants/styles.dart';
import 'package:news_app_assignment6/providers/provider_data.dart';
import 'package:news_app_assignment6/widgets/app_drawer.dart';
import 'package:news_app_assignment6/widgets/articles_listview_widget.dart';
import 'package:provider/provider.dart';
import 'package:news_app_assignment6/widgets/appBarIcons.dart';

import '../widgets/app_drawer.dart';
import '../widgets/filter_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dataClass = Provider.of<ProviderData>(context);
    return Scaffold(
      backgroundColor: scaffoldBackgroundcolor,
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          );
        }),
        backgroundColor: appBarThemeBackgroundColor,
        title: Text(appBarTitleText,
            style: GoogleFonts.satisfy(textStyle: appBarTitleStyle)),
        actions: const [
          AppBarIcons(Icons.notifications_outlined),
        ],
      ),
      body: Container(
        color: scaffoldBackgroundcolor,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterWidget(dataClass: dataClass),
                const VerticalDivider(
                  thickness: 4,
                ),
                const AppBarIcons(Icons.filter),
              ],
            ),
            const ArticlesFetched(),
          ],
        ),
      ),
    );
  }
}
