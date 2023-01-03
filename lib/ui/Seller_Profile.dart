import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/ui/Chat_Page.dart';
import 'package:mobidthrift/ui/Seller_Shop_Products.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

import '../constants/App_widgets.dart';

const LatLng currentLocation = LatLng(34.0151, 71.5249);

class SellerProfile extends StatefulWidget {
  const SellerProfile({Key? key}) : super(key: key);

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
      floatingActionButton: CircleAvatar( backgroundColor: Colors.transparent, radius: 50, child: IconButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage())); }, icon: Icon(Icons.chat, size: 35,color: AppColors.myIconColor,))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            CircleAvatar(
              radius: 44,
              child: Icon(Icons.image),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppWidgets().myHeading1Text("Shopkeeper's Name"),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Review '),
                      Row(
                        children: List.generate(
                            5,
                            (index) => Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 20,
                                )),
                      )
                    ],
                  ),
                  AppWidgets().myElevatedBTN(
                      onPressed: () {},
                      btnText: "Follow",
                      btnColor: Colors.blue,
                      btnHeight: 30.0),
                  SizedBox(
                    height: 10,
                  ),
                  AppWidgets().myHeading2Text('Contact:  0923456789'),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.red,),
                      AppWidgets().myHeading2Text('Location'),
                    ],
                  ),
                   SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: GoogleMap(
                          initialCameraPosition:
                              CameraPosition(
                                target: currentLocation,
                                zoom: 14
                              ),
                        onMapCreated: ((controller) {
                          _mapController = controller;
                          addMarker(id: 'test', location: currentLocation);
                        }),
                      )),
                  SizedBox(
                    height: 22,
                  ),
                  AppWidgets().myElevatedBTN(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SellerShopProducts()));
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
    var markerIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/images/phone');
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(
        title: 'location'
      ),
        icon: markerIcon


    );
    _markers[id] = marker;
    setState(() {});
  }
}
