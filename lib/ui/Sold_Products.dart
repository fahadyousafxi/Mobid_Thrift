import 'package:flutter/material.dart';
import 'package:mobidthrift/providers/sold_products_provider.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:provider/provider.dart';

class SoldProducts extends StatefulWidget {
  const SoldProducts({Key? key}) : super(key: key);

  @override
  State<SoldProducts> createState() => _SoldProductsState();
}

class _SoldProductsState extends State<SoldProducts> {
  SoldProductsProvider soldProductsProvider = SoldProductsProvider();

  @override
  void initState() {
    SoldProductsProvider soldProductsProvider =
        Provider.of(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    soldProductsProvider = Provider.of(context);
    soldProductsProvider.getSoldProductsData();
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'Sold Products'),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: soldProductsProvider.getSoldProductsDataList.length,
          itemBuilder: (BuildContext context, int index) {
            var data = soldProductsProvider.getSoldProductsDataList[index];

            return Padding(
              padding: const EdgeInsets.only(top: 3, right: 0, left: 0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     TextButton(
                      //       onPressed: () {},
                      //       child: Text('Removeasdfsadfs'),
                      //     ),
                      //     TextButton(
                      //       onPressed: () {},
                      //       child: Text('Edit'),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 142,
                        child: Image(
                          // The Data will be loaded from firebse
                          image: NetworkImage(data.productImage1!),
                          // fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(data.productName!),
                      SizedBox(
                        height: 11,
                      ),
                      Text(
                        data.productDescription!,
                        maxLines: 1,
                      ),
                      Text('Price: Rs.${data.productPrice!}'),
                      Text(data.sellerStatus!.toString()),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
