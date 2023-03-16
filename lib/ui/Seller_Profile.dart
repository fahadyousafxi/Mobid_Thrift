import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/providers/seller_provider.dart';
import 'package:mobidthrift/ui/Seller_Shop_Products.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:provider/provider.dart';

import '../chat_module/screens/chat_screen.dart';
import '../constants/App_widgets.dart';
import 'Review_Page.dart';

const LatLng currentLocation = LatLng(34.0151, 71.5249);

class SellerProfile extends StatefulWidget {
  String? contactNo;
  String? email;
  String? name;
  double? reviews;
  int? totalNoOfReviews;
  String? profileImage;
  String? uId;
  SellerProfile(
      {required this.name,
      required this.profileImage,
      required this.uId,
      required this.email,
      required this.contactNo,
      required this.reviews,
      required this.totalNoOfReviews,
      Key? key})
      : super(key: key);

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  SellerProvider sellerProvider = SellerProvider();

  late GoogleMapController _mapController;

  final _fireStoreSnapshot =
      FirebaseFirestore.instance.collection('SellerCenterUsers');

  Map<String, Marker> _markers = {};

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
    // sellerProvider.getSellerReviewsData(widget.uId.toString());

    // sellerProvider.getSellerReviewsDataList;
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'MobidThrift'),
      floatingActionButton: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50,
          child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      name: widget.name,
                      uId: widget.uId,
                      key: widget.key,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.chat,
                size: 35,
                color: AppColors.myIconColor,
              ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot>(
                future: _fireStoreSnapshot.doc(widget.uId).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    ));

                  if (snapshot.hasError)
                    return Center(child: Text('Some Error'));

                  return Column(
                    children: [
                      const SizedBox(height: 15),
                      widget.profileImage == ''
                          ? CircleAvatar(
                              radius: 44,
                              backgroundImage:
                                  const AssetImage('assets/images/img.png'))
                          : CircleAvatar(
                              radius: 44,
                              backgroundImage:
                                  NetworkImage(widget.profileImage!),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppWidgets().myHeading1Text("${widget.name}"),
                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReviewPage(
                                            reviews: widget.reviews,
                                            totalNoOfReviews:
                                                widget.totalNoOfReviews,
                                            uId: widget.uId)));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Review '),
                                  Row(
                                    children: List.generate(
                                        5,
                                        (index) => const Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 20,
                                            )),
                                  ),
                                  Text(
                                      ' (${snapshot.data!['Total_Review_Rating']}.000'
                                              .toString()
                                              .substring(0, 5) +
                                          ')'),
                                ],
                              ),
                            ),
                            AppWidgets().myElevatedBTN(
                                onPressed: () {},
                                btnText: "Follow",
                                btnColor: Colors.blue,
                                btnHeight: 30.0),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppWidgets().myHeading2Text(
                                    'Phone:    ${widget.contactNo}'),
                                AppWidgets().myHeading2Text(
                                    'Email:    ${widget.email}'),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.red,
                                ),
                                AppWidgets().myHeading2Text('Location'),
                              ],
                            ),
                            SizedBox(
                                height: 200,
                                width: MediaQuery.of(context).size.width / 1.3,
                                child: GoogleMap(
                                  initialCameraPosition: const CameraPosition(
                                      target: currentLocation, zoom: 14),
                                  onMapCreated: ((controller) {
                                    _mapController = controller;
                                    addMarker(
                                        id: 'test', location: currentLocation);
                                  }),
                                )),
                            const SizedBox(
                              height: 22,
                            ),
                            AppWidgets().myElevatedBTN(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SellerShopProducts(
                                                sellerUid:
                                                    widget.uId.toString(),
                                              )));
                                },
                                btnText: "View Shop Products",
                                btnColor: Colors.blue,
                                btnHeight: 30.0),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Reviews',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 15),
              child: SizedBox(
                child: ListView.builder(
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
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            Container(
              height: 44,
            )
          ],
        ),
      ),
    );
  }

  addMarker({required String id, required LatLng location}) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/images/phone');
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: const InfoWindow(title: 'location'),
        icon: markerIcon);
    _markers[id] = marker;
    setState(() {});
  }
}
