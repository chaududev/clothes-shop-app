import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/view/productlist_page.dart';
import 'provider/cart/cart_provider.dart';
import 'provider/product_provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>CartProvider()),
          ChangeNotifierProvider(create: (_)=>ProductProvider()),
        ],
        child : MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProductListPage(),
        ),
      )
  );
}


