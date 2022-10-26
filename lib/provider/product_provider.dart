import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:untitled/model/product_model.dart';
import 'package:http/http.dart' as http;
class ProductProvider extends ChangeNotifier{
  bool loaded = false;
  List<ProductModel> list = [];
  List<ProductModel>listOrigin = [];

  // ignore: non_constant_identifier_names
  void getList(String categoryChoose,int state,) async {
    String urlAPI;
    if (categoryChoose=="all") {
      urlAPI = "https://fakestoreapi.com/products";
    } else {
      urlAPI = "https://fakestoreapi.com/products/category/"+categoryChoose;
    }
    var client = http.Client();
    var rs = await client.get(Uri.parse(urlAPI));
    var jsonString = rs.body;
    var jsonObject = jsonDecode(jsonString) as List;
    if (state==0) {
      list = jsonObject.map((e) {
        return ProductModel(
            id: e['id'],
            title: e['title'],
            price: e['price'],
            description: e['description'],
            category: e['category'],
            image: e['image'],
            rating : Rating(
              rate : e['rating']['rate'],
              count : e['rating']['count'],
            ),
        );
      }).toList();
    }
    else if (state==1){
      list = jsonObject.map((e) {
        return ProductModel(
            id: e['id'],
            title: e['title'],
            price: e['price'],
            description: e['description'],
            category: e['category'],
            image: e['image'],
            rating : Rating(
              rate : e['rating']['rate'],
              count : e['rating']['count'],
            ),
        );
      }).toList();

      list.sort((a, b) => a.price!.compareTo(b.price!));
    }
    else if (state==2){
      list = jsonObject.map((e) {
        return ProductModel(
            id: e['id'],
            title: e['title'],
            price: e['price'],
            description: e['description'],
            category: e['category'],
            image: e['image'],
            rating : Rating(
              rate : e['rating']['rate'],
              count : e['rating']['count'],
            ),
        );
      }).toList();
      list.sort((a, b) => b.price!.compareTo(a.price!));
    }
    listOrigin = list;
    loaded=true;
    notifyListeners();
  }

  void searchProducts(String keyword){
      //list = list.sort((a, b) => a.title.compareTo(b.),)
    list = listOrigin.where((e) => e.title!.toUpperCase().contains(keyword.toUpperCase())).toList();
    notifyListeners();
  }
  void getProductByRating(int rating){
   try{
     list = listOrigin.where((e){
       bool correct = e.rating?.rate as double>=rating;

       return correct;
     }).toList();
     notifyListeners();
   }catch(ex){
     print(ex.toString());
   }
  }

}