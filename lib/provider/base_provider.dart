
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../model/product_cart.dart';

class BaseProvider extends ChangeNotifier{

    bool isLoaded = false;
    bool hasError = false;

}