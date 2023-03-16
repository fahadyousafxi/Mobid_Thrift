import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/Product_page.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:provider/provider.dart';

import '../../constants/App_colors.dart';
import '../../providers/Product_Provider.dart';

class MoreCellPhones extends StatefulWidget {
  const MoreCellPhones({Key? key}) : super(key: key);

  @override
  State<MoreCellPhones> createState() => _MoreCellPhonesState();
}

class _MoreCellPhonesState extends State<MoreCellPhones> {
  ProductsProvider cellPhonesProductProvider = ProductsProvider();

  @override
  void initState() {
    ProductsProvider cellPhonesProductProvider =
        Provider.of(context, listen: false);
    cellPhonesProductProvider.fitchCellPhonesProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cellPhonesProductProvider = Provider.of(context);

    return Scaffold(
      appBar: MyAppbar().myAppBar(context),
      // drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.filter_list),
              color: AppColors.myIconColor,
            ),
            Center(child: AppWidgets().myHeading1Text('Phones')),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: cellPhonesProductProvider
                      .getCellPhonesProductsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2 / 2.4),
                  itemBuilder: (context, index) {
                    var data = cellPhonesProductProvider
                        .getCellPhonesProductsList[index];
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
                                          productShipping: data.productShipping,
                                          productPrice: data.productPrice,
                                          productPTAApproved:
                                              data.productPTAApproved = true,
                                          productShopkeeperUid:
                                              data.productShopkeeperUid,
                                          productSpecification:
                                              data.productSpecification,
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
                                Text(data.productName.toString()),
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
                          )),
                    );
                  }),
              // child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250, mainAxisSpacing: 8, crossAxisSpacing: 10),
              //   children: [
              //     Card(
              //       clipBehavior: Clip.antiAlias,
              //       elevation: 4,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(11.0),
              //       ),
              //       child: GestureDetector(
              //           onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
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
              //                 AppWidgets().myHeading2Text('Product name'),
              //                 SizedBox(height: 8,),
              //                 Text('First line of discription'),
              //                 Text('Rs.400 is current bid '),
              //                 Text('1 Day time left '),
              //                 SizedBox(height: 22,)
              //               ],
              //             ),
              //           )
              //       ),
              //     ),
              //
              //
              //
              //     Card(
              //       clipBehavior: Clip.antiAlias,
              //       elevation: 4,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(11.0),
              //       ),
              //       child: GestureDetector(
              //           onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
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
              //                 AppWidgets().myHeading2Text('Product name'),
              //                 SizedBox(height: 8,),
              //                 Text('First line of discription'),
              //                 Text('Rs.400 is current bid '),
              //                 Text('1 Day time left '),
              //               ],
              //             ),
              //           )
              //       ),
              //     ),
              //
              //
              //
              //
              //     Card(
              //       clipBehavior: Clip.antiAlias,
              //       elevation: 4,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(11.0),
              //       ),
              //       child: GestureDetector(
              //           onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
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
              //                 AppWidgets().myHeading2Text('Product name'),
              //                 SizedBox(height: 8,),
              //                 Text('First line of discription'),
              //                 Text('Rs.400 is current bid '),
              //                 Text('1 Day time left '),
              //               ],
              //             ),
              //           )
              //       ),
              //     ),
              //
              //
              //
              //
              //
              //     Card(
              //       clipBehavior: Clip.antiAlias,
              //       elevation: 4,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(11.0),
              //       ),
              //       child: GestureDetector(
              //           onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
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
              //                 AppWidgets().myHeading2Text('Product name'),
              //                 SizedBox(height: 8,),
              //                 Text('First line of discription'),
              //                 Text('Rs.400 is current bid '),
              //                 Text('1 Day time left '),
              //               ],
              //             ),
              //           )
              //       ),
              //     ),
              //
              //
              //
              //
              //
              //
              //     Card(
              //       clipBehavior: Clip.antiAlias,
              //       elevation: 4,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(11.0),
              //       ),
              //       child: GestureDetector(
              //           onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
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
              //                 AppWidgets().myHeading2Text('Product name'),
              //                 SizedBox(height: 8,),
              //                 Text('First line of discription'),
              //                 Text('Rs.400 is current bid '),
              //                 Text('1 Day time left '),
              //                 SizedBox(height: 22,)
              //               ],
              //             ),
              //           )
              //       ),
              //     ),
              //
              //
              //
              //     Card(
              //       clipBehavior: Clip.antiAlias,
              //       elevation: 4,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(11.0),
              //       ),
              //       child: GestureDetector(
              //           onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
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
              //                 AppWidgets().myHeading2Text('Product name'),
              //                 SizedBox(height: 8,),
              //                 Text('First line of discription'),
              //                 Text('Rs.400 is current bid '),
              //                 Text('1 Day time left '),
              //               ],
              //             ),
              //           )
              //       ),
              //     ),
              //
              //
              //
              //
              //     Card(
              //       clipBehavior: Clip.antiAlias,
              //       elevation: 4,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(11.0),
              //       ),
              //       child: GestureDetector(
              //           onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
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
              //                 AppWidgets().myHeading2Text('Product name'),
              //                 SizedBox(height: 8,),
              //                 Text('First line of discription'),
              //                 Text('Rs.400 is current bid '),
              //                 Text('1 Day time left '),
              //               ],
              //             ),
              //           )
              //       ),
              //     ),
              //   ],
              //
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
