import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:morphosis_flutter_demo/locator.dart';
import 'package:morphosis_flutter_demo/non_ui/database/newsHive.dart';
import 'package:morphosis_flutter_demo/ui/screens/tasks.dart';
import 'package:morphosis_flutter_demo/viewModel/newsViewModel.dart';
import 'package:morphosis_flutter_demo/viewModel/taskViewModel.dart';
import '../../viewModel/newsViewModel_test.dart';


class MockMyViewModel extends Mock implements NewsRepo{}

class MockMyTaskViewModel extends Mock implements TaskViewModel{}


void main() {
  setupLocator();
  var newState = locator<NewsState>();

  newState.service = MockApi();

  MockHiveInterface mockHiveInterface;
  MockHiveBox mockHiveBox;
  NewsRepo newsRepo;
  MockMyTaskViewModel mockMyTaskviewModel;

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockHiveBox();
    newsRepo = NewsRepo(hive: mockHiveInterface);
    mockMyTaskviewModel = MockMyTaskViewModel();
  });

  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

testWidgets("check if task page has an title input", (WidgetTester tester)async{
  await tester.pumpWidget(createWidgetForTesting(child: TasksPage(tasks:mockMyTaskviewModel.tasks , title: "foo",)));

  expect(find.text("foo"), findsOneWidget);
});





}