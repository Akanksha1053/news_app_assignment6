import 'package:flutter/material.dart';
import 'package:news_app_assignment6/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:news_app_assignment6/providers/provider_data.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    Key? key,
    required this.dataClass,
  }) : super(key: key);

  final ProviderData dataClass;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.21,
      margin: const EdgeInsets.only(top: 10, left: 10),
      height: 30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dataClass.horizFilterList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                dataClass.toggleFilterOptions(index);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: dataClass.horizFilterList[index].isActive
                        ? filterListContainerBackgroundActiveColor
                        : filterListContainerBackgroundInActiveColor),
                child: TextButton(
                  onPressed: null,
                  child: Text(
                    dataClass.horizFilterList[index].filterName,
                    style: TextStyle(
                        color: dataClass.horizFilterList[index].isActive
                            ? filterListActiveTextColor
                            : filterListInActiveTextColor),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
