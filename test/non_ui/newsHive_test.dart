import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:morphosis_flutter_demo/locator.dart';
import 'package:morphosis_flutter_demo/non_ui/database/newsHive.dart';
import 'package:morphosis_flutter_demo/viewModel/newsViewModel.dart';

import '../viewModel/newsViewModel_test.dart';

class MockHiveBox extends Mock implements Box {}

void main() {
  setupLocator();
  MockHiveInterface mockHiveInterface;
  MockHiveBox mockHiveBox;
  NewsRepo newsRepo;
  var newState = locator<NewsState>();
  newState.service = MockApi();
  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockHiveBox();
    newsRepo = NewsRepo(hive: mockHiveInterface);
  });

  group('cache news list', () {


    test(
        'Should cache new list',
            () async{
              await newState.getNews();

          //arrange
          when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
          //act
          await newsRepo.cacheNews(newState.news);
          //assert
          verify(mockHiveBox.put('news', newState.news));
          verify(mockHiveInterface.openBox("news"));
        });

  });



}