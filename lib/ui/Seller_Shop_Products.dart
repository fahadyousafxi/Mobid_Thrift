import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/shop_keeper_products_provider.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:mobidthrift/ui/product_page_for_guests.dart';
import 'package:provider/provider.dart';

import 'Product_page.dart';

class SellerShopProducts extends StatefulWidget {
  String? sellerUid;
  SellerShopProducts({required this.sellerUid, Key? key}) : super(key: key);

  @override
  State<SellerShopProducts> createState() => _SellerShopProductsState();
}

class _SellerShopProductsState extends State<SellerShopProducts> {
  ShopKeeperProductsProvider productProvider = ShopKeeperProductsProvider();

  final _auth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    ShopKeeperProductsProvider productsProvider =
        Provider.of(context, listen: false);
    productsProvider.fitchCellPhonesProducts(widget.sellerUid);
    productsProvider.fitchPadsTabletsProducts(widget.sellerUid);
    productsProvider.fitchLaptopsProducts(widget.sellerUid);
    productsProvider.fitchSmartWatchesProducts(widget.sellerUid);
    productsProvider.fitchDesktopsProducts(widget.sellerUid);
    productsProvider.fitchAccessoriesProducts(widget.sellerUid);
    productsProvider.fitchPartsProducts(widget.sellerUid);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    productProvider.getSearchProductsList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    productProvider = Provider.of(context);
    return Scaffold(
      appBar: MyAppbar().myAppBar(context),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            AppWidgets().myHeading2Text('Shopkeeper Name'),
            SizedBox(
              height: 11,
            ),
            Expanded(
              child: SizedBox(
                // height: size.height / 1.4,
                width: size.width / 1.4,
                child: ListView.builder(
                    itemCount: productProvider.getSearchProductsList.length,
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      var data = productProvider.getSearchProductsList[index];
                      // children: cellPhonesProductProvider
                      //     .getPadsTabletsProductsList
                      //     .map((PadsTabletsProducts) {
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        child: GestureDetector(
                            onTap: () {
                              print(
                                  productProvider.getSearchProductsList.length);
                              _auth != null
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductPage(
                                                bidEndTimeInSeconds: data
                                                    .bidEndTimeInSeconds!
                                                    .toInt(),
                                                productName:
                                                    data.productName.toString(),
                                                productCurrentBid:
                                                    data.productCurrentBid,
                                                productDescription: data
                                                    .productDescription
                                                    .toString(),
                                                productUid:
                                                    data.productUid.toString(),
                                                productImage1: data
                                                    .productImage1
                                                    .toString(),
                                                productShipping:
                                                    data.productShipping,
                                                productPrice: data.productPrice,
                                                productPTAApproved:
                                                    data.productPTAApproved,
                                                productShopkeeperUid:
                                                    data.productShopkeeperUid,
                                                productSpecification:
                                                    data.productSpecification,
                                              )))
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductPageForGuests(
                                                bidEndTimeInSeconds:
                                                    data.bidEndTimeInSeconds,
                                                productName:
                                                    data.productName.toString(),
                                                productCurrentBid:
                                                    data.productCurrentBid,
                                                productDescription: data
                                                    .productDescription
                                                    .toString(),
                                                productUid:
                                                    data.productUid.toString(),
                                                productImage1: data
                                                    .productImage1
                                                    .toString(),
                                                productShipping:
                                                    data.productShipping,
                                                productPrice: data.productPrice,
                                                productPTAApproved:
                                                    data.productPTAApproved,
                                                productShopkeeperUid:
                                                    data.productShopkeeperUid,
                                                productSpecification:
                                                    data.productSpecification,
                                              )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: 178,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      // width: 155,
                                      height: 120,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(11),
                                        child: Image(
                                          // The Data will be loaded from firebse
                                          image: NetworkImage(
                                              data.productImage1.toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data.productName.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      data.productDescription.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                        'Price: Rs.${data.productPrice.toString()}'),
                                    // Text('1 Day time left '),
                                    Text(' '),
                                  ],
                                ),
                              ),
                            )),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
