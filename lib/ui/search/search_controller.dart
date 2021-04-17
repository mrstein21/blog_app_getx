import 'package:blog_getx/model/topic.dart';
import 'package:blog_getx/repository/article_repository.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var topic = new List<Topic>().obs;
  ArticleRepository articleRepository = Get.find<ArticleRepository>();
  var isLoading = true.obs;

  void getTopic() {
    isLoading(true);
    articleRepository.getTopic().then((value) {
      topic.value = value;
      isLoading(false);
    });
  }
}
