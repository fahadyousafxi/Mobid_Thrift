import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:mobidthrift/providers/Product_Provider.dart';
import 'package:mobidthrift/providers/Wish_List_Provider.dart';
import 'package:mobidthrift/providers/chats_provider.dart';
import 'package:mobidthrift/providers/followers_provider.dart';
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
  PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

  runApp(MyApp(initialLink: initialLink));
} // comment for git 16

class MyApp extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;
  const MyApp({super.key, required this.initialLink});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  String? path;

  @override
  initState() {
    if (widget.initialLink != null) {
      path = widget.initialLink!.link!.path;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishListProvider()),
        ChangeNotifierProvider(create: (_) => SellerProvider()),
        ChangeNotifierProvider(create: (_) => TradeInProvider()),
        ChangeNotifierProvider(create: (_) => ShopKeeperProductsProvider()),
        ChangeNotifierProvider(create: (_) => SoldProductsProvider()),
        ChangeNotifierProvider(create: (_) => ChatsProvider()),
        ChangeNotifierProvider(create: (_) => FollowersProvider()),
      ],
      child: MaterialApp(
        title: 'Mobid Thrift',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: SplashScreen(path: path),
      ),
    );
  }
}
