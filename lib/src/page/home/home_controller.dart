import 'package:get/get.dart';

class HomeController extends GetxController{

  var counter = 0.obs;

  void add(){
    counter++;
    update([counter]);
  }
}