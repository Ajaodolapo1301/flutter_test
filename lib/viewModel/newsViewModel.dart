
import 'package:morphosis_flutter_demo/non_ui/database/newsHive.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/news.dart';
import 'package:morphosis_flutter_demo/services/newsService.dart';

import 'package:morphosis_flutter_demo/viewModel/baseModel.dart';

import '../locator.dart';
import 'package:hive/hive.dart';




class NewsState extends BaseModel   {
Box box;
NewsRepo newsRepo = NewsRepo(hive: Hive);
  AbstractNews service = locator<AbstractNews>();

  List<NewsModel> _news= [];
  List<NewsModel> get news => _news;
  set news(List<NewsModel> news1) {
    _news = news1;
    notifyListeners();
  }



  List _filteredList = <NewsModel>[];
  List get filteredList => _filteredList;

  set filteredList(List<NewsModel> news1) {
    _news = news1;
    notifyListeners();
  }





  // addItem(List <NewsModel> item) async {
  //
  //   box.put("news", item);
  // }

  // onSearch(v) async {
  //   if (v != null) {
  //     filteredList = news.where((news) => news.title.toString().toLowerCase().contains(v))
  //         .toList();
  //   }else if (filteredList.isEmpty){
  //     filteredList = news;
  //   }



  //   notifyListeners();
  // }







  Future<void> getNews() async{
    try{
      setBusy(true);
   var   newss = await service.getNews();
     newsRepo.getNewsCached(newss);
      setBusy(false);
    }catch(e){

    }

  }


}