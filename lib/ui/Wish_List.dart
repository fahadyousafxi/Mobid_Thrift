import 'package:flutter/material.dart';
import 'package:mobidthrift/providers/Wish_List_Provider.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  WishListProvider wishListProvider = WishListProvider();


  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider.getWishListData();
    return Scaffold(

      appBar: MyAppbar().mySimpleAppBar(context, title: "Wish List"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('asdfasdfsdfsfa'),
            Expanded(
              child: ListView.builder(itemCount: wishListProvider.getWishListDataList.length, itemBuilder: (context, index) {

                var data = wishListProvider.getWishListDataList[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ProductPageOfCart(cartName: data.cartName.toString(), cartCurrentBid: data.cartCurrentBid, cartDescription: data.cartDescription.toString(), cartUid: data.cartUid.toString(), cartImage1: data.cartImage1.toString(), cartShipping: data.cartShipping, cartPrice: data.cartPrice, cartPTAApproved: data.cartPTAApproved, cartShopkeeperUid: data.cartShopkeeperUid, cartSpecification: data.cartSpecification,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              // width: 162,
                              child: Column(
                                children: [
                                  SizedBox(

                                    height: 130,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(11),
                                      child: Image(

                                        // The Data will be loaded from firebse
                                        image: NetworkImage(data.wishlistUid.toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Center(child: Text(data.productUid.toString(), style: TextStyle(fontWeight: FontWeight.bold),)),
                                  SizedBox(height: 2,),
                                  Text(data.collectionName.toString(), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                  Row(
                                    children: [
                                      Text('Rs.${data.collectionName.toString()} ', style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text('is current bid '),
                                    ],
                                  ),
                                  Text('1 Day time left '),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                );

              }),
            ),

          ],
        ),
      ),
    );
  }
}
