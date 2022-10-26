
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:counter_button/counter_button.dart';

import '../../model/product_cart.dart';
import '../../model/product_model.dart';
import '../../provider/cart/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  
  _getCart(){
    var cartProvider = Provider.of<CartProvider>(context,listen: false);
    cartProvider.initCart();
  //cartProvider.products
  }
  _setAmount(int val,ProductCart product){
    var cartProvider = Provider.of<CartProvider>(context,listen: false);
    cartProvider.setAmountProduct(product, val);
  }
  
  @override
  void initState() {
    // TODO: implement initState
    _getCart();
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
            'My cart',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
      body:Consumer<CartProvider>(builder: ((context, value, child) => Container(
          child: Column(
            children: [
             Container(height: 600,child: ListView.builder(
               itemCount: value.products.length,
               itemBuilder: (context, index){
                 var cart=value.products;
                 return Container(
                   margin: EdgeInsets.all(20),
                   child: Row(
                     children: [
                       Expanded(
                         child: Container(
                           child: Image.network(cart[index].img),
                         ),flex: 3,),
                       SizedBox(width: 20,),
                       Expanded(
                         flex: 7,
                         child: Container(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(  maxLines: 2,
                                 overflow: TextOverflow.ellipsis,
                                 cart[index].productName,style: const TextStyle(
                                     fontSize: 24
                                 ),),
                               SizedBox(height: 10,),
                               Text(cart[index].price.toString()+ ' \$',style: const TextStyle(fontSize: 20),),
                               SizedBox(height: 10,),
                               CounterButton(
                                 loading: false,
                                 onChange: (int val) {
                                   _setAmount(val,cart[index]);

                                 },
                                 count: cart[index].amount as int,
                                 countColor: Colors.purple,
                                 buttonColor: Colors.purpleAccent,
                                 progressColor: Colors.purpleAccent,
                               )
                             ],
                           ),
                         ),)
                     ],
                   ),
                 );

               },)
               ,),
              SizedBox(height: 30,),
              Container(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    text: 'Tổng cộng ',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                    children: <TextSpan>[
                      TextSpan(text: value.total.toStringAsFixed(2).toString()+' \$',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                    ],
                  ),
                ),
              ),
              SizedBox(height:30,),
              Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.pink),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 100,
                      child: Text("Checkout", style: TextStyle(fontSize: 18),),
                    )
                ),
              )
          ],)
      )),));
  }
}
