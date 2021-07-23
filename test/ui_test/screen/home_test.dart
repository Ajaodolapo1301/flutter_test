


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:morphosis_flutter_demo/locator.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/news.dart';
import 'package:morphosis_flutter_demo/ui/screens/home.dart';

import 'package:morphosis_flutter_demo/viewModel/newsViewModel.dart';
import 'package:provider/provider.dart';

import '../../viewModel/newsViewModel_test.dart';


// class MockMyViewModel extends Mock implements NewsState{}




void main() {
  setupLocator();
  var newState = locator<NewsState>();
  newState.service = MockApi();


  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  void _verifyAllCarDetails(List<NewsModel> newsList, WidgetTester tester) async {
    for (var news in newsList) {
      final newsFindr = find.text(news.title);
      await tester.ensureVisible(newsFindr);
      expect(newsFindr, findsOneWidget);


    }
  }

    group("Home page test", () {
    testWidgets('Testing search field', (WidgetTester tester) async {
      List <NewsModel> newsModel = await MockApi().getNews();
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NewsState()),

        ],
        child: Builder(
          builder: (_) => createWidgetForTesting(child: HomePage()),
        ),
      ));

      var textField = find.byKey(ValueKey("searchField"));

      expect(textField, findsOneWidget);
      await tester.enterText(textField, 'Flutter Devs');
        // expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
      expect(find.text('Flutter Devs'), findsOneWidget);



    });
    testWidgets("Check for  cupertinoWidget", (WidgetTester tester) async{
      await newState.getNews();
      await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => NewsState()),

            ],
            child: Builder(
              builder: (_) => createWidgetForTesting(child: HomePage()),
            ),
          ));
  _verifyAllCarDetails(newState.news, tester);
    });

  });
}