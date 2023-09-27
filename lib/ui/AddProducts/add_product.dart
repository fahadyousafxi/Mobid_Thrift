// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';

import '../../constants/App_colors.dart';
import '../../constants/App_widgets.dart';
import '../../utils/utils.dart';
import '../Trade_Your_Product.dart';
import '../appbar/My_appbar.dart';

class AddProduct extends StatefulWidget {
  var productCollectionName;
  AddProduct({required this.productCollectionName, Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedFiles = [];
  FirebaseStorage _storageRef = FirebaseStorage.instance;
  List<String> _imagesUrls = [];
  int uploadItem = 0;
  bool _isUploading = false;

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance.currentUser;

  bool isStartingBid = true;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _productSpecificationController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startingBidController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _shippingPriceController =
      TextEditingController();

  final _myFormKey = GlobalKey<FormState>();
  int? startingBid;
  int? productPrice;
  int? productShipping;
  bool ptaApproved = false;

  bool buttonEnable = false;
  bool imageUploaded = false;

  String? downloadImageUrl;
  File? pickedImage;
  bool showLocalImage = false;
  // pickImageFrom(ImageSource fromGalleryOrCamera) async {
  //   XFile? file = await ImagePicker()
  //       .pickImage(source: fromGalleryOrCamera, imageQuality: 80);
  //   if (file == null) {
  //     return;
  //   }
  //
  //   pickedImage = File(file.path);
  //   showLocalImage = true;
  //   setState(() {});
  //   ProgressDialog progressDialog = ProgressDialog(
  //     context,
  //     title: const Text('Uploading !!!'),
  //     message: const Text('Please wait'),
  //   );
  //   progressDialog.show();
  //   try {
  //     var fileName = '${DateTime.now().microsecondsSinceEpoch}.jpg';
  //     UploadTask uploadTask = FirebaseStorage.instance
  //         .ref()
  //         .child('products_images')
  //         .child(fileName)
  //         .putFile(pickedImage!);
  //     TaskSnapshot snapshot = await uploadTask;
  //     downloadImageUrl = await snapshot.ref.getDownloadURL();
  //     print(downloadImageUrl);
  //     // _fireStore.collection(collectionPath).doc(_firebaseAuth.currentUser?.uid.toString()).update({
  //     //   'Profile_Image' : profileImageUrl,
  //     // });
  //     progressDialog.dismiss();
  //     Utils.flutterToast(' Image Uploaded ');
  //     imageUploaded = true;
  //   } catch (e) {
  //     progressDialog.dismiss();
  //     print(e.toString());
  //     Utils.flutterToast(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var collectionName = widget.productCollectionName.toString();
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: "Add Product Details"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _myFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _isUploading
                      ? showLoading()
                      : Column(
                          children: [
                            const Text('Add Product Image'),
                            Center(
                              child: _selectedFiles.isEmpty
                                  ? InkWell(
                                      onTap: () {
                                        if (_selectedFiles != null) {
                                          _selectedFiles.clear();
                                        }
                                        selectImages();
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          border:
                                              Border.all(color: Colors.black),
                                          // image: DecorationImage(image: pickedImage != null ? Image.file(pickedImage!).image : NetworkImage(''))
                                        ),
                                        child: const Center(
                                            child: Icon(
                                          Icons.add_a_photo_outlined,
                                          size: 33,
                                        )),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.4,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount:
                                                    _selectedFiles.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Image.file(
                                                      File(_selectedFiles[index]
                                                          .path),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      if (_selectedFiles !=
                                                          null) {
                                                        _selectedFiles.clear();
                                                        _imagesUrls.clear();
                                                      }
                                                      imageUploaded = false;
                                                      setState(() {});
                                                    },
                                                    icon: Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.red,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      selectImages();
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .add_a_photo_outlined,
                                                      color: Colors.green,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AppWidgets().myElevatedBTN(
                                            onPressed: () {
                                              if (_selectedFiles.isNotEmpty) {
                                                uploadFunction(_selectedFiles);
                                              } else {
                                                Utils.flutterToast(
                                                    'There is no images selected');
                                              }
                                            },
                                            btnText: 'Upload Images',
                                            btnColor: Colors.blue),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppWidgets().myTextFormField(
                      hintText: 'Enter a title',
                      labelText: 'Title',
                      controller: _titleController,
                      validator: (String? txt) {
                        bool isTitleValid =
                            RegExp(r'^[a-zA-Z\s]+[0-9]*$').hasMatch(txt!);

                        if (isTitleValid) {
                          return null;
                        }
                        if (txt == null || txt.isEmpty) {
                          return "Please provide the title";
                        }

                        return 'Should be a valid name of the device';
                      },
                      fillColor: Colors.grey.shade300,
                      labelColor: Colors.black,
                      hintColor: Colors.black,
                      borderSideColor: Colors.black,
                      textColor: Colors.black),
                  const SizedBox(
                    height: 10,
                  ),
                  AppWidgets().myTextFormField(
                      hintText: 'Enter a description',
                      labelText: 'Description',
                      controller: _descriptionController,
                      validator: (String? txt) {
                        if (txt == null || txt.isEmpty) {
                          return "Please provide description";
                        }

                        return null;
                      },
                      fillColor: Colors.grey.shade300,
                      labelColor: Colors.black,
                      hintColor: Colors.black,
                      borderSideColor: Colors.black,
                      textColor: Colors.black),
                  const SizedBox(
                    height: 10,
                  ),
                  AppWidgets().myTextFormField(
                      validator: (String? txt) {
                        if (txt == null || txt.isEmpty) {
                          return "Please provide specifications";
                        }

                        return null;
                      },
                      hintText: 'Enter the specifications',
                      labelText: 'Specification',
                      controller: _productSpecificationController,
                      fillColor: Colors.grey.shade300,
                      labelColor: Colors.black,
                      hintColor: Colors.black,
                      borderSideColor: Colors.black,
                      textColor: Colors.black),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text("Biding"),
                  //     Switch(
                  //         value: isStartingBid,
                  //         onChanged: (bool) {
                  //           setState(() {
                  //             isStartingBid == false
                  //                 ? isStartingBid = true
                  //                 : isStartingBid = false;
                  //           });
                  //         }),
                  //     isStartingBid == true
                  //         ? const Icon(
                  //             Icons.check,
                  //             color: Colors.green,
                  //           )
                  //         : const Icon(
                  //             Icons.clear,
                  //             color: Colors.red,
                  //           ),
                  //     Text(isStartingBid == false ? 'Off' : 'On'),
                  //   ],
                  // ),
                  // isStartingBid == false
                  //     ? SizedBox()
                  //     : AppWidgets().myTextFormField(
                  //         hintText: 'Enter a starting bid price',
                  //         myType: const TextInputType.numberWithOptions(),
                  //         labelText: 'Starting Bid',
                  //         controller: _startingBidController,
                  //         fillColor: Colors.grey.shade300,
                  //         labelColor: Colors.black,
                  //         hintColor: Colors.black,
                  //         borderSideColor: Colors.black,
                  //         textColor: Colors.black,
                  //         validator: (String? txt) {
                  //           if (txt == null || txt.isEmpty) {
                  //             startingBid = 0;
                  //             return null;
                  //           }
                  //
                  //           startingBid =
                  //               int.parse(_startingBidController.text);
                  //           return null;
                  //         },
                  //       ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppWidgets().myTextFormField(
                    hintText: 'Enter total price',
                    myType: const TextInputType.numberWithOptions(),
                    labelText: 'Total Price',
                    controller: _productPriceController,
                    fillColor: Colors.grey.shade300,
                    labelColor: Colors.black,
                    hintColor: Colors.black,
                    borderSideColor: Colors.black,
                    textColor: Colors.black,
                    validator: (String? txt) {
                      if (txt == null || txt.isEmpty || txt.length > 9999999) {
                        return "Please provide price";
                      }

                      productPrice = int.parse(_productPriceController.text);
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppWidgets().myTextFormField(
                    hintText: 'Enter the shipping price',
                    myType: const TextInputType.numberWithOptions(),
                    labelText: 'Shipping Price',
                    controller: _shippingPriceController,
                    fillColor: Colors.grey.shade300,
                    labelColor: Colors.black,
                    hintColor: Colors.black,
                    borderSideColor: Colors.black,
                    textColor: Colors.black,
                    validator: (String? txt) {
                      if (txt == null || txt.isEmpty || txt.length > 99999) {
                        return "Please provide shipping price";
                      }

                      productShipping =
                          int.parse(_shippingPriceController.text);
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("PTA Approved"),
                      Switch(
                          value: ptaApproved,
                          onChanged: (bool) {
                            setState(() {
                              ptaApproved == false
                                  ? ptaApproved = true
                                  : ptaApproved = false;
                            });
                          }),
                      ptaApproved == true
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                      Text(ptaApproved == false ? 'No' : 'Yes'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppWidgets().myElevatedBTN(
                      onPressed: () {
                        print('${_titleController.text}');
                        if (imageUploaded == true) {
                          if (_myFormKey.currentState!.validate()) {
                            if (buttonEnable == false) {
                              ProgressDialog progressDialog = ProgressDialog(
                                context,
                                title: const Text('Uploading !!!'),
                                message: const Text('Please wait'),
                              );

                              setState(() {
                                progressDialog.show();
                              });
                              var docUid = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();

                              _fireStore
                                  .collection('TradeInProducts')
                                  .doc('FrY6ftMAx233dpQTwZac')
                                  .collection(collectionName)
                                  .doc(docUid)
                                  .set({
                                'productImages': _imagesUrls,
                                'productImage1': _imagesUrls[0],
                                'IsStartingBid': isStartingBid,
                                'productCollectionName': collectionName,
                                'productName': _titleController.text.toString(),
                                'productCurrentBid': startingBid,
                                'productDescription':
                                    _descriptionController.text.toString(),
                                'productSpecification':
                                    _productSpecificationController.text
                                        .toString(),
                                'productPTAApproved': ptaApproved,
                                'productPrice': productPrice,
                                'productShipping': productShipping,
                                'productUid': docUid.toString(),
                                'productShopkeeperUid': _auth!.uid.toString(),
                              }).then((value) {
                                setState(() {
                                  progressDialog.dismiss();
                                });
                                Utils.flutterToast('Product has been uploaded');
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TradeYourProduct()));
                              }).onError((error, stackTrace) {
                                Utils.flutterToast(error.toString());
                                setState(() {
                                  progressDialog.dismiss();
                                });
                              });
                            } else {
                              Utils.flutterToast('Please wait');
                            }
                          }
                        } else {
                          Utils.flutterToast(
                              'Please add Image or wait to upload');
                        }
                      },
                      btnText: 'Submit',
                      btnColor: AppColors.myRedColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// bottom Sheet
  // Future bottomSheet(context) {
  //   return showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return SafeArea(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               ListTile(
  //                 leading: const Icon(Icons.camera_alt),
  //                 title: const Text('With Camera'),
  //                 onTap: () {
  //                   pickImageFrom(ImageSource.camera);
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //               ListTile(
  //                 leading: const Icon(Icons.storage),
  //                 title: const Text('From Gallery'),
  //                 onTap: () {
  //                   pickImageFrom(ImageSource.gallery);
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

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
        .child('tradeIn_products_images')
        .child(_auth!.uid.toString() + 'products')
        .child(_image.name);
    UploadTask uploadTask = reference.putFile(File(_image.path));
    await uploadTask.whenComplete(() {
      setState(() {
        uploadItem++;
        if (uploadItem == _selectedFiles.length) {
          _isUploading = false;

          imageUploaded = true;
          Utils.flutterToast('uploaded');
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
