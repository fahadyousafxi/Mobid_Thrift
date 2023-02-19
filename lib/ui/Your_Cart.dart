import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:mobidthrift/ui/Product_Page_of_Cart.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:provider/provider.dart';


class YourCart extends StatefulWidget {
  const YourCart({Key? key}) : super(key: key);

  @override
  State<YourCart> createState() => _YourCartState();
}

class _YourCartState extends State<YourCart> {

  CartProvider cartProvider = CartProvider();
  @override
  void initState() {
    // CartProvider initCartProvider = CartProvider();
    // initCartProvider.getCartData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);
    cartProvider.getCartData();
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'Your Cart'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(itemCount: cartProvider.getCartDataList.length, itemBuilder: (context, index) {

                var data = cartProvider.getCartDataList[index];
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
                                builder: (context) => ProductPageOfCart(cartName: data.cartName.toString(), cartCurrentBid: data.cartCurrentBid, cartDescription: data.cartDescription.toString(), cartUid: data.cartUid.toString(), cartImage1: data.cartImage1.toString(), cartShipping: data.cartShipping, cartPrice: data.cartPrice, cartPTAApproved: data.cartPTAApproved, cartShopkeeperUid: data.cartShopkeeperUid, cartSpecification: data.cartSpecification,)));
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
                                        image: NetworkImage(data.cartImage1.toString()),
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


                                  Center(child: Text(data.cartName.toString(), style: TextStyle(fontWeight: FontWeight.bold),)),
                                  SizedBox(height: 2,),
                                  Text(data.cartDescription.toString(), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                  Row(
                                    children: [
                                      Text('Rs.${data.cartCurrentBid.toString()} ', style: TextStyle(fontWeight: FontWeight.bold),),
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
      bottomNavigationBar: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.myBlackColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 1,),
            AppWidgets()
                .myHeading2Text('Total: \$0', color: AppColors.myWhiteColor),
            AppWidgets().myElevatedBTN(
                onPressed: () {},
                btnText: 'Checkout',
                btnColor: AppColors.myRedColor)
          ],
        ),
      ),
    );
  }
}
