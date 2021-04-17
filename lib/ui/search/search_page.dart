import 'package:blog_getx/mixins/server.dart';
import 'package:blog_getx/routes.dart';
import 'package:blog_getx/ui/search/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  TextEditingController searchQueryController = new TextEditingController();
  SearchController searchController;

  @override
  Widget build(BuildContext context) {
    searchController=Get.find<SearchController>();
    searchController.getTopic();
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Container(
            padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              // color: Color.fromARGB(58, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchQueryController,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (String terms) {
                      print(terms);
                      if(terms.length>3){
                        Get.toNamed(RouterGenerator.routeSearchResult,arguments: {
                          "keyword":terms
                        });
                      }else{
                        Get.snackbar("Pesan", "Minimal 4 kata untuk melakukan pencarian");
                      }
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Search..",
                        hintStyle: TextStyle(color: Colors.white),
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          )),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Search by Topics",style: TextStyle(fontFamily: "Roboto",fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 8,
            ),
            Obx(
                ()=> Wrap(
                children: searchController.topic.map<Widget>((e){
                  return InkWell(
                    onTap: (){
                      Get.toNamed(RouterGenerator.routeSearchByTags,arguments: {
                        "tags":e.id.toString(),
                        "tags_name":e.topic_name
                      });
                      // Navigator.pushNamed(context, RouterGenerator.routeSearchByTags,
                      //     arguments: {
                      //       "tags":e.id.toString(),
                      //       "tags_name":e.topic_name
                      //     });
                    },
                    child: Padding(
                        child: Material(
                          color: Colors.white,
                          elevation: 1,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: IntrinsicWidth(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircleAvatar(
                                      backgroundImage:
                                      NetworkImage(Server.url + e.cover),
                                      radius: 50,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    e.topic_name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.all(10)
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
