import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobidthrift/models/Product_Model.dart';
import 'package:mobidthrift/providers/Product_Provider.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:mobidthrift/ui/product_page_for_guests.dart';
import 'package:provider/provider.dart';

import 'Product_page.dart';

class SearchPage extends StatefulWidget {
  final List<ProductModel>? searchProducts;
  const SearchPage({this.searchProducts, Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _auth = FirebaseAuth.instance.currentUser;

  ProductsProvider productsProvider = ProductsProvider();

  String query = '';

  // searchItem(String query){
  //   List<ProductModel>? searchingItem = widget.searchProducts?.where((element) {
  //     return element.productName!.toLowerCase().contains(query);
  //   }).toList();
  //   return searchingItem;
  // }
  searchItem(String query) {
    List<ProductModel> searchingItem = productsProvider.getSearchProductsList
        .where((element) {
          return element.productName!.toLowerCase().contains(query);
        })
        .toList()
        .where((element) {
          return element.productPTAApproved != ptaNotApproved ||
              element.productPTAApproved != ptaApproved;
        })
        .toList();
    return searchingItem;
  }

  bool ptaApproved = true;
  bool ptaNotApproved = false;

  var f = NumberFormat('00', 'en_US');
  int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  @override
  void initState() {
    ProductsProvider initProductsProvider = Provider.of(context, listen: false);
    initProductsProvider.getSearchProductsList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productsProvider = Provider.of(context);
    List<ProductModel> _searchItem = searchItem(query);
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'Search Item'),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5),
            child: TextField(
              onChanged: (value) {
                print(value);
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: Hero(
                      tag: 'forSearch',
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                  // prefixIconConstraints: BoxConstraints(minWidth: 10, minHeight: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.only(top: 1, left: 1, bottom: 1),
                  hintText: 'Search'),
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 11,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    ptaNotApproved = !ptaNotApproved;
                    ptaApproved = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: ptaNotApproved == false
                          ? Colors.grey
                          : Colors.redAccent.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('PTA Not Approved')),
                  ),
                ),
              ),
              SizedBox(
                width: 11,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    ptaApproved = !ptaApproved;
                    ptaNotApproved = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: ptaApproved == true
                          ? Colors.grey
                          : Colors.greenAccent.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('PTA Approved')),
                  ),
                ),
              ),
            ],
          ),
          productsProvider.getCellPhonesProductsList.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : Expanded(
                  child: GridView.builder(
                      itemCount: _searchItem.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2 / 2.4),
                      itemBuilder: (context, index) {
                        var data = _searchItem[index];
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                          child: GestureDetector(
                              onTap: () {
                                _auth != null
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                                  isStartingBid:
                                                      data.isStartingBid,
                                                  bidEndTimeInSeconds:
                                                      data.bidEndTimeInSeconds,
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
                                                  productCollectionName: data
                                                      .productCollectionName,
                                                )))
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductPageForGuests(
                                                  isStartingBid:
                                                      data.isStartingBid,
                                                  bidEndTimeInSeconds:
                                                      data.bidEndTimeInSeconds,
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
                                                  productCollectionName: data
                                                      .productCollectionName,
                                                )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    SizedBox(
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
                                    data.isStartingBid == true
                                        ? Text(
                                            'Rs.${data.productCurrentBid.toString()}  is current bid ')
                                        : SizedBox(),
                                    data.isStartingBid == false
                                        ? Text('Not on Auction')
                                        : (data.bidEndTimeInSeconds! -
                                                    currentTime) >=
                                                0
                                            ? Text(
                                                '${((data.bidEndTimeInSeconds! - currentTime) ~/ 86400)}Days  ${f.format(((data.bidEndTimeInSeconds! - currentTime) % 86400) ~/ 3600)}hr time left ')
                                            : Text('Time Up')
                                  ],
                                ),
                              )),
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
