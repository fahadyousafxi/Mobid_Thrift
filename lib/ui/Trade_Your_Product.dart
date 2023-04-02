import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobidthrift/ui/AddProducts/add_product_screen.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:provider/provider.dart';

import '../constants/App_colors.dart';
import '../constants/App_widgets.dart';
import '../providers/trade_in_provider.dart';

class TradeYourProduct extends StatefulWidget {
  const TradeYourProduct({Key? key}) : super(key: key);

  @override
  State<TradeYourProduct> createState() => _TradeYourProductState();
}

class _TradeYourProductState extends State<TradeYourProduct> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedFiles = [];
  FirebaseStorage _storageRef = FirebaseStorage.instance;
  List<String> _imagesUrls = [];
  int uploadItem = 0;
  bool _isUploading = false;

  TradeInProvider productProvider = TradeInProvider();

  @override
  void initState() {
    TradeInProvider productsProvider = Provider.of(context, listen: false);
    productsProvider.fitchCellPhonesProducts();
    productsProvider.fitchPadsTabletsProducts();
    productsProvider.fitchLaptopsProducts();
    productsProvider.fitchSmartWatchesProducts();
    productsProvider.fitchDesktopsProducts();
    productsProvider.fitchAccessoriesProducts();
    productsProvider.fitchPartsProducts();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    productProvider.getSearchProductsList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    // productProvider.fitchCellPhonesProducts();
    // productProvider.fitchPadsTabletsProducts();
    // productProvider.fitchLaptopsProducts();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'Trade Your Product'),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            productProvider.getSearchProductsList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Still Searching'),
                        Text('But there is no products'),
                        Text('Add a product'),
                      ],
                    )),
                  )
                : SizedBox(
                    height: size.height / 1.3,
                    width: size.width / 1.4,
                    child: ListView.builder(
                        itemCount: productProvider.getSearchProductsList.length,
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          var data =
                              productProvider.getSearchProductsList[index];
                          // children: cellPhonesProductProvider
                          //     .getPadsTabletsProductsList
                          //     .map((PadsTabletsProducts) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.0),
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  print(productProvider
                                      .getSearchProductsList.length);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ProductPage(
                                  //           productName: data.productName
                                  //               .toString(),
                                  //           productCurrentBid:
                                  //           data.productCurrentBid,
                                  //           productDescription: data
                                  //               .productDescription
                                  //               .toString(),
                                  //           productUid: data.productUid
                                  //               .toString(),
                                  //           productImage1: data
                                  //               .productImage1
                                  //               .toString(),
                                  //           productShipping:
                                  //           data.productShipping,
                                  //           productPrice:
                                  //           data.productPrice,
                                  //           productPTAApproved:
                                  //           data.productPTAApproved,
                                  //           productShopkeeperUid:
                                  //           data.productShopkeeperUid,
                                  //           productSpecification:
                                  //           data.productSpecification,
                                  //         )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    width: 178,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          // width: 155,
                                          height: 120,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            child: Image(
                                              // The Data will be loaded from firebse
                                              image: NetworkImage(data
                                                  .productImage1
                                                  .toString()),
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
                                        Text(
                                            'Price: Rs.${data.productPrice.toString()}'),
                                        // Text('1 Day time left '),
                                        Text(' '),
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        }),
                  ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      )
          // _isUploading
          //     ? showLoading()
          //     : Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           ElevatedButton(
          //               onPressed: () {
          //                 selectImages();
          //               },
          //               child: Text('Chose Images')),
          //           SizedBox(
          //             height: 22,
          //           ),
          //           ElevatedButton(
          //               onPressed: () {
          //                 if (_selectedFiles.isNotEmpty) {
          //                   uploadFunction(_selectedFiles);
          //                 } else {
          //                   Utils.flutterToast('There is no images selected');
          //                 }
          //               },
          //               child: Text('Upload')),
          //           SizedBox(
          //             height: 22,
          //           ),
          //           _selectedFiles == null
          //               ? Text('No Images is Selected')
          //               : Text(
          //                   'Images Selected: ${_selectedFiles.length.toString()}'),
          //           SizedBox(
          //             height: 222,
          //             child: ListView.builder(
          //               scrollDirection: Axis.horizontal,
          //               shrinkWrap: true,
          //               itemCount: _selectedFiles.length,
          //               itemBuilder: (BuildContext context, int index) {
          //                 return Image.file(
          //                   File(_selectedFiles[index].path),
          //                   fit: BoxFit.cover,
          //                 );
          //               },
          //             ),
          //           )
          //         ],
          //       )
          ),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.myWhiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppWidgets().myElevatedBTN(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductScreen()));
                },
                btnText: 'Add Product',
                btnColor: AppColors.myRedColor),
          ],
        ),
      ),
    );
  }

  Widget showLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "uploading :  ${uploadItem.toString()}/${_selectedFiles.length.toString()}"),
          SizedBox(
            height: 22,
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  void uploadFunction(List<XFile> _images) {
    setState(() {
      _isUploading = true;
    });
    for (int i = 0; i < _images.length; i++) {
      uploadFile(_images[i]);
    }
  }

  Future<String> uploadFile(XFile _image) async {
    final _auth = FirebaseAuth.instance.currentUser;
    Reference reference = _storageRef
        .ref()
        .child(_auth!.uid.toString() + 'products')
        .child(_image.name);
    UploadTask uploadTask = reference.putFile(File(_image.path));
    await uploadTask.whenComplete(() {
      setState(() {
        uploadItem++;
        if (uploadItem == _selectedFiles.length) {
          _isUploading = false;

          uploadItem = 0;
        }
      });
    });
    String downloadURL = await reference.getDownloadURL();
    print('************************ url ****************************');
    print(downloadURL);

    _imagesUrls.add(downloadURL.toString());

    return downloadURL;
  }

  Future<void> selectImages() async {
    if (_selectedFiles != null) {
      _selectedFiles.clear();
    }
    try {
      final List<XFile> imgs = await _picker.pickMultiImage(imageQuality: 70);
      if (imgs!.isNotEmpty) {
        _selectedFiles.addAll(imgs);
      }
      print('the legth of list: ${imgs.length.toString()}');
    } catch (e) {
      print('Something Went Wrong${e.toString()}');
    }
    setState(() {});
  }
}
