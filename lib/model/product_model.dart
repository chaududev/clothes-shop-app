class ProductModel {
  num? id;
  String? title;
  num? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  ProductModel({this.id,this.title,this.price,this.description,this.category,this.image,this.rating});
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ??"Title NULL";
    price = json['price'] == null ? 0.0 : json['price'].toDouble();
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    return data;
  }
  int compareTo(other) {
    if (price! < other.price) {
      return -1;
    }

    // age > other.age
    if (price! > other.price) {
      return 1;
    }

    // age == other.age
    return 0;
  }
}
class Rating {
  double? rate;
  int? count;
  Rating({this.rate, this.count});
  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'] == null ? 0.0 : json['rate'].toDouble();
    count = json['count'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}