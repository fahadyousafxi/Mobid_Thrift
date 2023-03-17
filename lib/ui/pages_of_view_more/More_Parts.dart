import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/Product_page.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:provider/provider.dart';

import '../../constants/App_colors.dart';
import '../../providers/Product_Provider.dart';

class MoreParts extends StatefulWidget {
  const MoreParts({Key? key}) : super(key: key);

  @override
  State<MoreParts> createState() => _MorePartsState();
}

class _MorePartsState extends State<MoreParts> {
  ProductsProvider productProvider = ProductsProvider();

  @override
  void initState() {
    ProductsProvider productProvider = Provider.of(context, listen: false);
    productProvider.fitchPartsProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);

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
                  itemCount: productProvider.getPartsProductsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2 / 2.4),
                  itemBuilder: (context, index) {
                    var data = productProvider.getPartsProductsList[index];
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
                                          productImage1:
                                              data.productImage1.toString(),
                                          productShipping: data.productShipping,
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
            ),
          ],
        ),
      ),
    );
  }
}
