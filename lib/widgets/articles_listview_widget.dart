import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:news_app_assignment6/constants/colors.dart';
import 'package:news_app_assignment6/constants/styles.dart';
import 'package:news_app_assignment6/screens/specific_news_screen.dart';
import 'package:provider/provider.dart';

import '../providers/provider_data.dart';

class ArticlesFetched extends StatefulWidget {
  const ArticlesFetched({
    Key? key,
  }) : super(key: key);

  @override
  State<ArticlesFetched> createState() => _ArticlesFetchedState();
}

class _ArticlesFetchedState extends State<ArticlesFetched> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) =>
        Provider.of<ProviderData>(context, listen: false).fetchArticles());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<ProviderData>(context);

    return Container(
      height: 700,
      color: scaffoldBackgroundcolor,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: providerData.fetchedArticles.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              providerData.currentIndex = index;
            });
            Navigator.pushNamed(context, SpecificNewsScreen.routeName);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            margin:
                const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
            height: 185,
            child: Material(
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: 200,
                            child: Text(
                                providerData.fetchedArticles[index].title,
                                softWrap: true,
                                style: newsHeadlineStyle),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      providerData
                                          .fetchedArticles[index].authorName,
                                      style: authorNameStyle),
                                  Text(
                                    providerData.fetchedArticles[index].dateTime
                                        .toString(),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      width: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            child: Image.network(
                              providerData.fetchedArticles[index].imageUrl,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
