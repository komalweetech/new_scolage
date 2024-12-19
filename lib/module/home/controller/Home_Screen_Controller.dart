// ignore_for_file: file_names

import 'package:get/get.dart';

import '../model/temp_college_category_model.dart';

class HomeScreenController extends GetxController {
  List<TempCollegeCategoryModel> collegeCategoryList = [
    TempCollegeCategoryModel(
        name: "M.P.C", description: "Mathematics, Physics & Chemistry"),
    TempCollegeCategoryModel(
        name: "Bi.P.C", description: "Biology, Physics & Chemistry"),
    TempCollegeCategoryModel(
        name: "C.E.C", description: "Commerce, Economics & Civics"),
    TempCollegeCategoryModel(
        name: "M.E.C", description: "Mathematics, Economics & Commerce"),
    TempCollegeCategoryModel(
        name: "H.E.C", description: "History, Economics & Civics "),
    TempCollegeCategoryModel(
        name: "C.E.G", description: "Commerce, Economics & Geography"),
    TempCollegeCategoryModel(name: "M.P.C/Bi.P.C with EAMCET", description: ""),
    TempCollegeCategoryModel(name: "M.P.C with AIEEE- Mains", description: ""),
    TempCollegeCategoryModel(name: "M.P.C with IIT- Advanced", description: ""),
    TempCollegeCategoryModel(name: "M.E.C with CA-CPT", description: ""),


  ];
}
