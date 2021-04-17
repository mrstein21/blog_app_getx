import 'package:blog_getx/model/article.dart';
import 'package:blog_getx/repository/article_repository.dart';
import 'package:get/get.dart';

class ListArticleController extends GetxController{
  var list=new List<Article>().obs;
  var isLoading=true.obs;
  var page=1.obs;
  var isNoMoreLoad=false.obs;
  ArticleRepository articleRepository=Get.find<ArticleRepository>();


  void getArticle() async{
    list.value=[];
    isLoading(true);
    isNoMoreLoad(false);
    page(1);
     var data=await articleRepository.getAllArticle(1);
     isLoading(false);
     list.value=[...list.value,...data];
  }



  void loadMore()async{
    print("kesini load more getX");
    page.value=page.value+1;
    var data=await articleRepository.getAllArticle(page.value);
    list.value=[...list.value,...data];
    if(data.isEmpty){
      isNoMoreLoad(true);
    }

  }


}