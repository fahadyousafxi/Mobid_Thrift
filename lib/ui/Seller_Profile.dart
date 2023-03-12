import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/ui/Review_Page.dart';
import 'package:mobidthrift/ui/Seller_Shop_Products.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

import '../chat_module/screens/chat_screen.dart';
import '../constants/App_widgets.dart';

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
  late GoogleMapController _mapController;
  Map<String, Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 15),
            CircleAvatar(
              radius: 44,
              backgroundImage: widget.profileImage == ''
                  ? const AssetImage('assets/images/img.png')
                  : AssetImage(widget.profileImage!),
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
                                  totalNoOfReviews: widget.totalNoOfReviews,
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
                        Text(' (${widget.reviews.toString().substring(0, 1)})'),
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
                  AppWidgets().myHeading2Text('Phone:    ${widget.contactNo}'),
                  AppWidgets().myHeading2Text('Email:    ${widget.email}'),
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
                          addMarker(id: 'test', location: currentLocation);
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
                                    const SellerShopProducts()));
                      },
                      btnText: "View Shop Products",
                      btnColor: Colors.blue,
                      btnHeight: 30.0),
                ],
              ),
            ),
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
