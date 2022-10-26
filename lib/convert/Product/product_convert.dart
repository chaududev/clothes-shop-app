

import '../../model/product_cart.dart';
import '../../model/product_model.dart';

class ProductConvert{
  static ProductCart toProductCart (ProductModel product){
     return ProductCart(product.id as num, product.title as String, product.price as num, product.image as String);
  }
}