import 'package:flutter/material.dart';
import 'package:news_app_assignment6/constants/colors.dart';
import 'package:news_app_assignment6/constants/styles.dart';
import 'package:news_app_assignment6/providers/provider_data.dart';
import 'package:news_app_assignment6/screens/home_screen.dart';
import 'package:provider/provider.dart';

class SpecificNewsScreen extends StatelessWidget {
  const SpecificNewsScreen({Key? key}) : super(key: key);

  static const routeName = '/specific-news';

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<ProviderData>(context);
    int index = providerData.currentIndex;
    return Scaffold(
      backgroundColor: scaffoldBackgroundcolor,
      appBar: AppBar(
        backgroundColor: appBarThemeBackgroundColor,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: appBarIconColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Coinstelly', style: appBarTitleStyle),
        actions: const [AppBarIcons(Icons.arrow_forward)],
      ),
      body: Material(
        elevation: 10,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(24),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    providerData.fetchedArticles[index].title,
                    style: newsHeadlineStyle,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        providerData.fetchedArticles[index].imageUrl,
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(height: 30),
                  Text(
                    providerData.fetchedArticles[index].description,
                    style: newsDescriptionStyle,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(providerData.fetchedArticles[index].authorName,
                              style: authorNameStyle),
                          Text(providerData.fetchedArticles[index].dateTime
                              .toString())
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.comment),
                                  Text(providerData.commentsInNews.toString())
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.red,
                              ),
                              Text(providerData.views.toString())
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Comments',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '(${providerData.commentsInNews})',
                        style: const TextStyle(
                            textBaseline: TextBaseline.alphabetic),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                          height: 30,
                          color: buttonBackgroundColor,
                          child: const TextButton(
                            onPressed: null,
                            child: Text('Add Comment', style: buttonTextStyle),
                          ))
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
