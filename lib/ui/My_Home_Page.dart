import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/Product_Provider.dart';
import 'package:mobidthrift/ui/pages_of_view_more/More_Accessories.dart';
import 'package:mobidthrift/ui/pages_of_view_more/More_Cell_Phones.dart';
import 'package:mobidthrift/ui/appbar/My_Drawer.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:mobidthrift/ui/pages_of_view_more/More_Desktops.dart';
import 'package:mobidthrift/ui/pages_of_view_more/More_Laptops.dart';
import 'package:mobidthrift/ui/pages_of_view_more/More_Pads_Tablets.dart';
import 'package:mobidthrift/ui/pages_of_view_more/More_Parts.dart';
import 'package:mobidthrift/ui/pages_of_view_more/More_Smart_Watches.dart';
import 'package:provider/provider.dart';

import 'Product_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProductsProvider productProvider = ProductsProvider();

  final _fireStoreSnapshot = FirebaseFirestore.instance
      .collection('BannerAd')
      .doc('asdfasdfasdfasdf')
      .get();

  @override
  void initState() {
    ProductsProvider productsProvider = Provider.of(context, listen: false);
    productsProvider.fitchCellPhonesProducts();
    productsProvider.fitchPadsTabletsProducts();
    productsProvider.fitchLaptopsProducts();
    productsProvider.fitchSmartWatchesProducts();
    productsProvider.fitchDesktopsProducts();
    productsProvider.fitchAccessoriesProducts();
    productsProvider.fitchPartsProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    // productProvider.fitchCellPhonesProducts();
    // productProvider.fitchPadsTabletsProducts();
    // productProvider.fitchLaptopsProducts();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppbar()
          .myAppBar(context, search: productProvider.getSearchProductsList),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  print((size.height / 4).toString());
                },
                icon: Icon(Icons.filter_list),
                color: AppColors.myIconColor,
              ),
              // AppWidgets().myAddBannerContainer(height: size.height / 4.2),
              FutureBuilder<DocumentSnapshot>(
                  future: _fireStoreSnapshot,
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));

                    if (snapshot.hasError)
                      return Center(child: Text('Some Error'));

                    return AspectRatio(
                      aspectRatio: 10/6,
                      child: Container(
                        margin: EdgeInsets.only(left: 0, bottom: 0, right: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: Colors.white,
                          image: DecorationImage(
                            // The Data will be loaded from firebse
                            image: NetworkImage(snapshot.data!['Banner_Ad'] ?? "assets/images/adbanner.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('    ' + snapshot.data!['Title'], maxLines: 1, overflow: TextOverflow.ellipsis,style: const TextStyle( fontSize: 22, fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.2, 0.2),
                                  blurRadius: 5.0,
                                  color: Colors.white,
                                ),
                                // Shadow(
                                //   offset: Offset(0.1, 0.1),
                                //   blurRadius: 8.0,
                                //   color: Color.fromARGB(125, 0, 0, 255),
                                // ),
                              ],
                            ),),
                            SizedBox(height: 22,)
                          ],
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 15,
              ),

              ///***************************** Cell Phones *****************************///
              AppWidgets().categoryRow(
                  categoryText: 'Cell Phones',
                  textButtonText: 'More Cell Phones',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoreCellPhones()));
                  }),
              // Row(
              //     children: cellPhonesProductProvider.getCellPhonesProductsList.map((e) {return Container(height: 33, width: 22, color: Colors.red, child: Text('data'));}).toList()
              // ),
              productProvider.getCellPhonesProductsList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SizedBox(
                      height: 240,
                      width: double.infinity,
                      child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: productProvider.getCellPhonesProductsList
                              .map((cellPhonesProducts) {
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11.0),
                              ),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                                  productName:
                                                      cellPhonesProducts
                                                          .productName
                                                          .toString(),
                                                  productCollectionName:
                                                      cellPhonesProducts
                                                          .productCollectionName,
                                                  productCurrentBid:
                                                      cellPhonesProducts
                                                          .productCurrentBid,
                                                  productDescription:
                                                      cellPhonesProducts
                                                          .productDescription
                                                          .toString(),
                                                  productUid: cellPhonesProducts
                                                      .productUid
                                                      .toString(),
                                                  productImage1:
                                                      cellPhonesProducts
                                                          .productImage1
                                                          .toString(),
                                                  productShipping:
                                                      cellPhonesProducts
                                                          .productShipping,
                                                  productPrice:
                                                      cellPhonesProducts
                                                          .productPrice,
                                                  productPTAApproved:
                                                      cellPhonesProducts
                                                              .productPTAApproved =
                                                          true,
                                                  productShopkeeperUid:
                                                      cellPhonesProducts
                                                          .productShopkeeperUid,
                                                  productSpecification:
                                                      cellPhonesProducts
                                                          .productSpecification,
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      width: 178,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            // width: 155,
                                            height: 120,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                              child: cellPhonesProducts
                                                      .productImage1!.isEmpty
                                                  ? CircularProgressIndicator()
                                                  : Image(
                                                      // The Data will be loaded from firebse
                                                      image: NetworkImage(
                                                          cellPhonesProducts
                                                              .productImage1
                                                              .toString()),
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            cellPhonesProducts.productName
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            cellPhonesProducts
                                                .productDescription
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                              'Rs.${cellPhonesProducts.productCurrentBid.toString()}  is current bid '),
                                          Text('1 Day time left '),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          }).toList()),
                    ),
              SizedBox(
                height: 15,
              ),

              ///***************************** Pads and Tablets *****************************///

              AppWidgets().categoryRow(
                  categoryText: 'Pads/Tablets',
                  textButtonText: 'More Pads/Tablets',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MorePadsTablets()));
                  }),
              productProvider.getPadsTabletsProductsList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SizedBox(
                      height: 240,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount:
                              productProvider.getPadsTabletsProductsList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            var data = productProvider
                                .getPadsTabletsProductsList[index];
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                                  productName: data.productName
                                                      .toString(),
                                                  productCurrentBid:
                                                      data.productCurrentBid,
                                                  productDescription: data
                                                      .productDescription
                                                      .toString(),
                                                  productUid: data.productUid
                                                      .toString(),
                                                  productImage1: data
                                                      .productImage1
                                                      .toString(),
                                                  productShipping:
                                                      data.productShipping,
                                                  productPrice:
                                                      data.productPrice,
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
                                            // width: 155,
                                            height: 120,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                              child: Image(
                                                // The Data will be loaded from firebse
                                                image: NetworkImage(data
                                                    .productImage1
                                                    .toString()),
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
                                          Text(data.productDescription
                                                  .toString()
                                                  .substring(0, 24) +
                                              '....'),
                                          Text(
                                              'Rs.${data.productCurrentBid.toString()}  is current bid '),
                                          Text('1 Day time left '),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          }

                          // children: [
                          //     Card(
                          //       clipBehavior: Clip.antiAlias,
                          //       elevation: 4,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(11.0),
                          //       ),
                          //       child: GestureDetector(
                          //           onTap: () {
                          //             Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                     builder: (context) => ProductPage()));
                          //           },
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(5.0),
                          //             child: Column(
                          //               children: [
                          //                 SizedBox(
                          //
                          //                   height: 112,
                          //                   child: Image(
                          //                     // The Data will be loaded from firebse
                          //                     image: AssetImage("assets/images/phone.png"),
                          //                     // fit: BoxFit.cover,
                          //                   ),
                          //                 ),
                          //                 Text('Product name'),
                          //                 Text('First line of discription'),
                          //                 Text('Rs.400  is current bid '),
                          //                 Text('1 Day time left '),
                          //               ],
                          //             ),
                          //           )),
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          // ]

                          ),
                    ),
              SizedBox(
                height: 15,
              ),

              ///***************************** Smart Watches *****************************///

              AppWidgets().categoryRow(
                  categoryText: 'Smart Watches',
                  textButtonText: 'More Smart Watches',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoreSmartWatches()));
                  }),
              productProvider.getSmartWatchesProductsList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SizedBox(
                      height: 240,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: productProvider
                              .getSmartWatchesProductsList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            var data = productProvider
                                .getSmartWatchesProductsList[index];
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                                  productName: data.productName
                                                      .toString(),
                                                  productCurrentBid:
                                                      data.productCurrentBid,
                                                  productDescription: data
                                                      .productDescription
                                                      .toString(),
                                                  productUid: data.productUid
                                                      .toString(),
                                                  productImage1: data
                                                      .productImage1
                                                      .toString(),
                                                  productShipping:
                                                      data.productShipping,
                                                  productPrice:
                                                      data.productPrice,
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
                                            // width: 155,
                                            height: 120,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                              child: Image(
                                                // The Data will be loaded from firebse
                                                image: NetworkImage(data
                                                    .productImage1
                                                    .toString()),
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
                                              'Rs.${data.productCurrentBid.toString()}  is current bid '),
                                          Text('1 Day time left '),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          }),
                    ),
              SizedBox(
                height: 15,
              ),

              ///***************************** Laptops *****************************///

              AppWidgets().categoryRow(
                  categoryText: 'Laptops',
                  textButtonText: 'More Laptops',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MoreLaptops()));
                  }),
              productProvider.getLaptopsProductsList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SizedBox(
                      height: 240,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount:
                              productProvider.getLaptopsProductsList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            var data =
                                productProvider.getLaptopsProductsList[index];
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                                  productName: data.productName
                                                      .toString(),
                                                  productCurrentBid:
                                                      data.productCurrentBid,
                                                  productDescription: data
                                                      .productDescription
                                                      .toString(),
                                                  productUid: data.productUid
                                                      .toString(),
                                                  productImage1: data
                                                      .productImage1
                                                      .toString(),
                                                  productShipping:
                                                      data.productShipping,
                                                  productPrice:
                                                      data.productPrice,
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
                                            height: 120,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                              child: Image(
                                                // The Data will be loaded from firebase
                                                image: NetworkImage(data
                                                    .productImage1
                                                    .toString()),
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
                                              'Rs.${data.productCurrentBid.toString()}  is current bid '),
                                          Text('1 Day time left '),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          }),
                    ),
              SizedBox(
                height: 15,
              ),

              ///***************************** Desktops *****************************///

              AppWidgets().categoryRow(
                  categoryText: 'Desktops',
                  textButtonText: 'More Desktops',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoreDesktops()));
                  }),
              productProvider.getDesktopsProductsList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SizedBox(
                      height: 240,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount:
                              productProvider.getDesktopsProductsList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            var data =
                                productProvider.getDesktopsProductsList[index];
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                                  productName: data.productName
                                                      .toString(),
                                                  productCurrentBid:
                                                      data.productCurrentBid,
                                                  productDescription: data
                                                      .productDescription
                                                      .toString(),
                                                  productUid: data.productUid
                                                      .toString(),
                                                  productImage1: data
                                                      .productImage1
                                                      .toString(),
                                                  productShipping:
                                                      data.productShipping,
                                                  productPrice:
                                                      data.productPrice,
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
                                            // width: 155,
                                            height: 120,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                              child: Image(
                                                // The Data will be loaded from firebse
                                                image: NetworkImage(data
                                                    .productImage1
                                                    .toString()),
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
                                              'Rs.${data.productCurrentBid.toString()}  is current bid '),
                                          Text('1 Day time left '),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          }),
                    ),
              SizedBox(
                height: 15,
              ),

              ///***************************** Accessories *****************************///

              AppWidgets().categoryRow(
                  categoryText: 'Accessories',
                  textButtonText: 'More Accessories',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoreAccessories()));
                  }),
              productProvider.getAccessoriesProductsList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SizedBox(
                      height: 240,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount:
                              productProvider.getAccessoriesProductsList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            var data = productProvider
                                .getAccessoriesProductsList[index];
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                                  productName: data.productName
                                                      .toString(),
                                                  productCurrentBid:
                                                      data.productCurrentBid,
                                                  productDescription: data
                                                      .productDescription
                                                      .toString(),
                                                  productUid: data.productUid
                                                      .toString(),
                                                  productImage1: data
                                                      .productImage1
                                                      .toString(),
                                                  productShipping:
                                                      data.productShipping,
                                                  productPrice:
                                                      data.productPrice,
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
                                            // width: 155,
                                            height: 120,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                              child: Image(
                                                // The Data will be loaded from firebse
                                                image: NetworkImage(data
                                                    .productImage1
                                                    .toString()),
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
                                              'Rs.${data.productCurrentBid.toString()}  is current bid '),
                                          Text('1 Day time left '),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          }),
                    ),
              SizedBox(
                height: 15,
              ),

              ///***************************** Parts *****************************///

              AppWidgets().categoryRow(
                  categoryText: 'Parts',
                  textButtonText: 'More Parts',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MoreParts()));
                  }),
              SizedBox(
                height: 240,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: productProvider.getPartsProductsList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      var data = productProvider.getPartsProductsList[index];
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                            productName:
                                                data.productName.toString(),
                                            productCurrentBid:
                                                data.productCurrentBid,
                                            productDescription: data
                                                .productDescription
                                                .toString(),
                                            productUid:
                                                data.productUid.toString(),
                                            productImage1:
                                                data.productImage1.toString(),
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
                                        'Rs.${data.productCurrentBid.toString()}  is current bid '),
                                    Text('1 Day time left '),
                                  ],
                                ),
                              ),
                            )),
                      );
                    }),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
