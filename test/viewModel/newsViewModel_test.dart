
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:morphosis_flutter_demo/locator.dart';
import 'package:morphosis_flutter_demo/non_ui/database/newsHive.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/news.dart';
import 'package:morphosis_flutter_demo/services/newsService.dart';
import 'package:morphosis_flutter_demo/viewModel/newsViewModel.dart';

class MockApi extends AbstractNews{
  @override
  Future<List<NewsModel>> getNews() {
    return Future.value([
      NewsModel(
        title: "my title",
        urlToImage: "www.google.com",
        description: "my description",
        publishedAt: "23/2/2009",
        author :'author',
        url :"url",
      ),

    ]);
  }
}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

// final Product mockProduct = Product(id: 1, name: "Product1", price: 111, imageUrl: "imageUrl");

void main() {
  setupLocator();
  var newState = locator<NewsState>();
  newState.service = MockApi();
  MockHiveInterface mockHiveInterface;
  MockHiveBox mockHiveBox;
  NewsRepo newsRepo;
  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockHiveBox();
    newsRepo = NewsRepo(hive: mockHiveInterface);
  });


    test('Page should load list of news', () async {
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);


      await newState.getNews();
      expect(newState.news.length, 1);
      expect(
          newState.news[0].title, 'my title');
      expect(newState.news[0].url, "url");
      expect(newState.news[0].urlToImage, 'www.google.com');
      expect(newState.news[0].author, "author");
    });



}
