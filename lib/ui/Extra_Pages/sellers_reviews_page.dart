import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/seller_provider.dart';

class SellersReviewPage extends StatefulWidget {
  String? uId;
  SellersReviewPage({required this.uId, Key? key}) : super(key: key);

  @override
  State<SellersReviewPage> createState() => _SellersReviewPageState();
}

class _SellersReviewPageState extends State<SellersReviewPage> {
  SellerProvider sellerProvider = SellerProvider();

  // final _fireStoreSnapshot =
  //     FirebaseFirestore.instance.collection('SellerCenterUsers');

  @override
  void initState() {
    SellerProvider sellerProvider = Provider.of(context, listen: false);
    sellerProvider.getSellerReviewsData(widget.uId.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sellerProvider = Provider.of(context);
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 15),
      child: SizedBox(
        // width: size.width / 2,
        child: sellerProvider.getSellerReviewsDataList.isEmpty
            ? Center(child: Text('No Reviews'))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: sellerProvider.getSellerReviewsDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = sellerProvider.getSellerReviewsDataList[index];
                  return Column(
                    children: [
                      Container(
                        // height: 111,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: Colors.black,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  '    Name: ' + data.name.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: List.generate(
                                      data.reviewRating!,
                                      (index) => const Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 20,
                                          )),
                                ),
                                Row(
                                  children: List.generate(
                                      5 - data.reviewRating!,
                                      (index) => const Icon(
                                            Icons.star,
                                            color: Colors.grey,
                                            size: 20,
                                          )),
                                ),
                                Text(
                                  '(${data.reviewRating})',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${data.review}',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }
}
