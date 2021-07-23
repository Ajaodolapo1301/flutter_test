


import 'package:morphosis_flutter_demo/services/dialogServices.dart';
import 'package:morphosis_flutter_demo/services/navigationServices.dart';

import 'package:get_it/get_it.dart';
import 'package:morphosis_flutter_demo/services/newsService.dart';
import 'package:morphosis_flutter_demo/viewModel/newsViewModel.dart';




GetIt locator = GetIt.asNewInstance();


void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton<AbstractNews>(() => NewsImpl());
  locator.registerLazySingleton(() => NewsState());
}