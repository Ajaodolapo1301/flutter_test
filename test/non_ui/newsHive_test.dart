import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:morphosis_flutter_demo/locator.dart';
import 'package:morphosis_flutter_demo/non_ui/database/newsHive.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/news.dart';
import 'package:morphosis_flutter_demo/viewModel/newsViewModel.dart';

import '../viewModel/newsViewModel_test.dart';

class MockHiveBox extends Mock implements Box {}
class MockHiveInterface extends Mock implements HiveInterface {}
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

  // group('cache news list', () {


    test(
        'Should cache new list',
            () async{


          //arrange
          when(mockHiveInterface.openBox("news")).thenAnswer((_) async => mockHiveBox);
              // when(mockHiveBox.get("news")).thenAnswer((_) async => newsRepo);
          //act
              when(mockHiveBox.get('news')).thenAnswer((realInvocation) async => realInvocation);
           newsRepo.cacheNews([NewsModel()]);
          //assert
              verify(mockHiveInterface.openBox("news"));
          // verify(mockHiveBox.put('news', [NewsModel()]));

        });





}