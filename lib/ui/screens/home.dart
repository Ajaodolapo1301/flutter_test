import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:morphosis_flutter_demo/constants/myUtils.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/news.dart';

import 'package:morphosis_flutter_demo/ui/widgets/newsWidget.dart';

import 'package:morphosis_flutter_demo/viewModel/baseModel.dart';
import 'package:morphosis_flutter_demo/viewModel/newsViewModel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AfterLayoutMixin<HomePage>{
  TextEditingController _searchTextField = TextEditingController();
  NewsState newsState;
  BaseModel baseModel;
Box box;
  List filteredList = <NewsModel>[];

  List<NewsModel> news =  [];
  @override
  void initState() {

    super.initState();
  }




  @override
  void dispose() {
    _searchTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    newsState = Provider.of<NewsState>(context, );
      if(filteredList.isEmpty){
        setState(() {
          filteredList = news;
        });
      }
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* In this section we will be testing your skills with network and local storage. You need to fetch data from any open source api from the internet. 
             E.g: 
             https://any-api.com/
             https://rapidapi.com/collection/best-free-apis?utm_source=google&utm_medium=cpc&utm_campaign=Beta&utm_term=%2Bopen%20%2Bsource%20%2Bapi_b&gclid=Cj0KCQjw16KFBhCgARIsALB0g8IIV107-blDgIs0eJtYF48dAgHs1T6DzPsxoRmUHZ4yrn-kcAhQsX8aAit1EALw_wcB
             Implement setup for network. You are free to use package such as Dio, Choppper or Http can ve used as well.
             Upon fetching the data try to store thmm locally. You can use any local storeage. 
             Upon Search the data should be filtered locally and should update the UI.
            */

            CupertinoSearchTextField(
              key: ValueKey("searchField"),
              controller: _searchTextField,
              onChanged: (v){
                    if(v.isNotEmpty){
                      setState(() {
                        filteredList = news.where((news) => news.title.toString().toLowerCase().contains(v)).toList();
                      });
                    }else{
                      setState(() {
                        filteredList =  news;
                      });
                    }


              }
            ),
SizedBox(height: 15,),
      Expanded(
        child:
        newsState.busy
            ? Center(
          child: CupertinoActivityIndicator(),
        )
            :
        ListView.separated(
            key: Key("newsList"),
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return newsWidget(
                  context: context, news: filteredList[index]);
            }),
      )
          ],
        ),
      ),
    );
  }




  void getNews() async {
try{
  await newsState.getNews();

}catch(e){
  print(e);
  MyUtils.kShowSnackBar(ctx: context, msg: e.toString(), color: Colors.red);
}

  }

  @override
  void afterFirstLayout(BuildContext context) {
    box = Hive.box("news");
    getNews();
    setState(() {
      news =  box.get("news").cast<NewsModel>();
    });
 print(news);

  }


}


