

class ProductCart{
  num id=0;
  String productName="";
  num price = 0;
  num amount=1;
   num _totalProduct=0;
   String img="";

  ProductCart(this.id,this.productName,this.price,this.img);

  num get totalProduct {
    return price  * amount ;
  }
  ProductCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    price = json["price"];
    amount = json['amount'];
    _totalProduct = json['totalProduct'];
    img = json['img'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['productName'] = this.productName;
    data['amount'] = this.amount;
    data['totalProduct'] = this.totalProduct;
    data['img'] = this.img;
    data["price"]=this.price;
    return data;
  }

}