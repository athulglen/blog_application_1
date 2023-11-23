import 'package:blog_application_1/Api%20Blog/services/api_services.dart';
import 'package:get/get.dart';
class PostController extends GetxController{
  var isLoading=true.obs;
  var postList=[].obs;

  var selectedUser;

  var users;

  @override
  void onInit(){
    getPosts();
    super.onInit();
  }
  void getPosts() async{
    try{
      isLoading(true);
      var posts=await HttpService.fetchPosts();
      // ignore: unnecessary_null_comparison
      if(posts!= null){
        postList.value=posts;
      }
    }catch(e){
      print(e);
    }finally{
      isLoading(false);
    }
  }

  void deletePost(id) {}
}