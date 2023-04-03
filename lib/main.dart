import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:mobidthrift/providers/Product_Provider.dart';
import 'package:mobidthrift/providers/Wish_List_Provider.dart';
import 'package:mobidthrift/providers/chats_provider.dart';
import 'package:mobidthrift/providers/seller_provider.dart';
import 'package:mobidthrift/providers/shop_keeper_products_provider.dart';
import 'package:mobidthrift/providers/sold_products_provider.dart';
import 'package:mobidthrift/providers/trade_in_provider.dart';
import 'package:mobidthrift/ui/Splash_Screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const MyApp());
} // comment for git 16

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsProvider>(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<SellerProvider>(
          create: (context) => SellerProvider(),
        ),
        ChangeNotifierProvider<TradeInProvider>(
          create: (context) => TradeInProvider(),
        ),
        ChangeNotifierProvider<ShopKeeperProductsProvider>(
          create: (context) => ShopKeeperProductsProvider(),
        ),
        ChangeNotifierProvider<SoldProductsProvider>(
          create: (context) => SoldProductsProvider(),
        ),
        ChangeNotifierProvider<ChatsProvider>(
          create: (context) => ChatsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Mobid Thrift',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
