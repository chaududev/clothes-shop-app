import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:untitled/provider/product_provider.dart';
import 'package:untitled/component/category_item.dart';
import 'package:provider/provider.dart';
import 'package:untitled/view/product_detail_page.dart';

import '../model/product_model.dart';
import '../provider/cart/cart_provider.dart';
import 'cart/cart_page.dart';
const List<String> list = <String>['0','1', '2', '3', '4'];

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  var _formKey = GlobalKey<FormState>();
  String dropdownValue = list.first;
  var _keyController = TextEditingController();
  List<String> Categorietitle = [
    "all",
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];
  int _value = 0;
  int state=0;
  bool showGrid=true;

  _getByRating(rating){
    var productProvider = Provider.of<ProductProvider>(context,listen: false);
    print(rating.toString());
    productProvider.getProductByRating(rating);
  }
  _searchData(keyword){
    var productProvider = Provider.of<ProductProvider>(context,listen: false);
    productProvider.searchProducts(keyword);
  }
  _getData (){
    var productProvider = Provider.of<ProductProvider>(context,listen: false);
    productProvider.getList(Categorietitle[_value].toString(),state);
  }
  addToCart(ProductModel product){
    var cartProvider = Provider.of<CartProvider>(context,listen: false);
  // print('Addd');
    cartProvider.addToCart(product);
  // print(cartProvider.products.length);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Shop Chau Du',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        leading:  IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Do something.
            }
        ),
          actions: <Widget> [
            IconButton(
            icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const CartPage()
                    )
                );
              },
          ),
          ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              buildSearch(context),
              SizedBox(height: 20,),
              buildCategory(context),
              SizedBox(height: 20,),
              buildSavePlace(context),
              SizedBox(height: 20,),
              showGrid? buildGrid(context):buildList(context)
            ],
          ),
        ),
      ),
    );
  }

  buildSearch(BuildContext context) {
    return Form(
      key:_formKey,
      child: TextField(
        controller: _keyController,
        onChanged: (content){
          //print(content);
          _searchData(content);

        },
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Tìm kiếm',
            prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
  buildSavePlace(BuildContext context) {
    return Row(
        children: [
          Text("Products",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Row(
            children: [
              IconButton(onPressed: (){
                setState((){
                  showGrid=true;
                });
              },
                  icon: Icon(Icons.grid_3x3,size : 30,)),
              IconButton(onPressed: (){
                setState((){
                  showGrid=false;
                });
              },
                  icon: Icon(Icons.list,size : 30,)),
              IconButton(onPressed: (){
                setState(() {
                  state=1;
                });
                _getData();
              },
                  icon: Icon(Icons.arrow_upward,size : 30,)),
              IconButton(onPressed: (){
                setState(() {
                  state=2;
                });
                _getData();
              },
                  icon: Icon(Icons.arrow_downward,size : 30,)),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.filter_alt),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                          ),
                onChanged: (String? value) {
                 // print(=);
                  _getByRating(int.parse(value.toString()));
                // This is called when the user selects an item.
                  setState(() {
                  dropdownValue = value!;
                   });
                 // _getData();
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Text('Từ '+value),
                  Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 202, 184, 20),
                  ),
                ],
              ),
              );
              }).toList(),
              ),
            ],
          )
        ]
    );
  }
  buildGrid(BuildContext context) {
    return Expanded(
      child:Consumer<ProductProvider>(
          builder: (context, value, child) => value.loaded?
          GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio:1/2,
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: value.list.length,
            itemBuilder: (context, index) =>
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetail(
                            product: value.list[index],
                          ), //you can pass the index (i) in the constructor of YourWidget(i) something like this if needed
                    ),
                  ),
                child : Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(value.list[index].image??"",height: 150,width: 120,)
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height:60,
                      child: Text(value.list[index].title??"Title NULL",textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                        maxLines: 3,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),),
                    ),
                    SizedBox(height: 5,),
                    Text(value.list[index].price==null?"":value.list[index].price.toString()+' \$' ,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.pink,
                      ),),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButton(
                          onPressed: () {
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.pink),
                          ),
                          child: InkWell(
                              onTap: (){
                                addToCart(value.list[index]);
                                Toast.show("Add ${value.list[index].title} to cart", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor:Colors.pink);
                              },
                              child: Text('Add to Cart',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),),
                    )
                  ],
                ),),
          ):Center(child:  CircularProgressIndicator(),)

      ),
    );
  }

  buildList(BuildContext context) {
    return Expanded(
      child: Consumer<ProductProvider>(
          builder: (context, value, child) => value.loaded?
          ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: value.list.length,
            itemBuilder: (context, index) =>
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetail(
                            product: value.list[index],
                          ), //you can pass the index (i) in the constructor of YourWidget(i) something like this if needed
                    ),
                  ),
                  child : Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(value.list[index].image??"",height: 150,width: 120,)
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height:60,
                        child: Text(value.list[index].title??"Title NULL",textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                          maxLines: 3,style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),),
                      ),
                      SizedBox(height: 5,),
                      Text(value.list[index].price==null?"":value.list[index].price.toString()+' \$' ,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.pink,
                        ),),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.pink),
                          ),
                          child: InkWell(
                              onTap: (){
                                addToCart(value.list[index]);
                                Toast.show("Add ${value.list[index].title} to cart", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor:Colors.pink);
                              },
                              child: Text('Add to Cart',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold))),),
                      )
                    ],
                  ),),
          ):Center(child:  CircularProgressIndicator(),)
      ),
    );
  }

  buildCategory(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(Categorietitle.length, (index) {
            return MyRadioListTile<int>(
              value: index,
              groupValue: _value,
              leading: Categorietitle[index].toUpperCase(),
              onChanged: (value) {
                setState(() {
                  _value = value!;
                });
                _getData();
              },
            );
          }),
        ),
      ),
    );
  }
}

