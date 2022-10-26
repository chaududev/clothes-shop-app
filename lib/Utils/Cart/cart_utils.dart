
import '../../model/product_cart.dart';
import '../../model/product_model.dart';

class CartUtils{
   static checkExistCart(List<ProductCart>carts, ProductModel product){
       int count = carts.where((item) =>item.id==product.id ).length;
       return count > 0;
   }
}