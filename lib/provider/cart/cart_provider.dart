



import 'dart:convert';

import 'package:localstorage/localstorage.dart';

import '../../Utils/Cart/cart_utils.dart';
import '../../convert/Product/product_convert.dart';
import '../../model/product_cart.dart';
import '../../model/product_model.dart';
import '../base_provider.dart';

class CartProvider extends BaseProvider{
  final LocalStorage storage =  LocalStorage('cart');
  List<ProductCart> products=[];
  double total = 0;
  itemTotal(){
    double sum = 0;
    for (var e in products) {
      sum += e.totalProduct;
    }
    total = sum;
    //notifyListeners();
  }

  initCart(){
    var json = storage.getItem("cart");
    if(json!=null){
      Iterable l = jsonDecode(storage.getItem("cart"));
     products =  List<ProductCart>.from(l.map<ProductCart>((dynamic i) => ProductCart.fromJson(i)));
    }
    itemTotal();
   notifyListeners();
  }
  setAmountProduct(ProductCart product,int amount){
    try{
      products = products.map((e){
        if(e.id==product.id)
        {
          e.amount = amount;
        }
      return e;
      }).toList();
      products = products.where((element) => element.amount>0).toList();
      itemTotal();
      notifyListeners();
    }catch(ex){
      print(ex.toString());
    }
  }

  addToCart(ProductModel product) {
    //check product exist in cart

    try {
      bool isExist = CartUtils.checkExistCart(products, product);
      if (isExist) {
        products = products.map((e) {
         // print(e.id==product.id);
          if (e.id == product.id) {
            e.amount++;
          }
          return e;
        }).toList();
      } else {
        products.add(ProductConvert.toProductCart(product));
      }
      var json = jsonEncode(products.map((e) => e.toJson()).toList());
      storage.setItem("cart",json);
    //  print(json.toString());
      itemTotal();
      notifyListeners();
    }
    catch (ex){
    print(ex.toString());
    }
  }
}