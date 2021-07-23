

import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/constants/color_utils.dart';
import 'package:morphosis_flutter_demo/constants/myUtils.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/news.dart';


Widget newsWidget({BuildContext context, NewsModel news}) {
  return GestureDetector(
    onTap: () {
      // pushTo(context, NewsDetails(
      //   newsModel: news,
      //
      // ));
    },
    child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: lightBlue,
        border: Border.all(
          color: borderBlue.withOpacity(0.05),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MyUtils.formatDate(news.publishedAt),
                  style: TextStyle(color: blue, fontSize: 10),
                ),
                SizedBox(height: 3),
                Text(news.title,
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(color:blue,


                  ),
                )
              ],
            ),
          ),

        ],
      ),
    ),
  );
}