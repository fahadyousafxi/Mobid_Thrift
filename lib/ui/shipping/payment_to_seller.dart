import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/bottom_navigation_bar.dart';
import 'package:mobidthrift/ui/shipping/shipping_tab_bar.dart';

import '../../utils/utils.dart';

class PaymentToSeller extends StatefulWidget {
  int? productShippingPrice;
  int? productPrice;
  String? productCollectionName;
  String? productUid;
  PaymentToSeller(
      {required this.productCollectionName,
      required this.productPrice,
      required this.productUid,
      required this.productShippingPrice,
      Key? key})
      : super(key: key);

  @override
  State<PaymentToSeller> createState() => _PaymentToSellerState();
}

class _PaymentToSellerState extends State<PaymentToSeller> {
  bool changeColor1 = false;
  bool changeColor2 = false;
  bool loading = false;
  bool loading1 = false;
  bool loading2 = false;

  bool editPhone = false;
  bool editAddress = false;

  bool _validate = false;
  bool _validate2 = false;

  String phoneNumber = '0';
  String address = 'a';

  TextEditingController _editPhone = TextEditingController();
  TextEditingController _editAddress = TextEditingController();

  final _currentUser = FirebaseAuth.instance.currentUser;
  final _firebaseFireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('MobidThrift'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 22,
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: _firebaseFireStore
                      .collection('users')
                      .doc(_currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());

                    if (snapshot.hasError)
                      return Center(child: Text('Some Error'));

                    phoneNumber = snapshot.data!['Phone_Number'].toString();
                    address = snapshot.data!['Address'].toString();
                    // if (snapshot.hasData && snapshot.data!.data() != null) {
                    //   final data =
                    //       snapshot.data!.data() as Map<String, dynamic>;
                    //   if (data.containsKey('Addressasdf')) {
                    //     print(data['Addressasdf'].toString());
                    //   } else {
                    //     // Handle the case where the 'Address' field is missing
                    //     print('Address field is missing.');
                    //   }
                    // }

                    print('***************** $phoneNumber************$address');
                    return Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Your Information',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Name:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _currentUser!.displayName.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Email:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _currentUser!.email.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Phone Number:  ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              editPhone == true
                                  ? Expanded(
                                      child: SizedBox(
                                        height: _validate ? 49 : 35,
                                        child: TextField(
                                          controller: _editPhone,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              errorText: _validate
                                                  ? 'Enter Phone number'
                                                  : null,
                                              alignLabelWithHint: false,
                                              border: OutlineInputBorder(
                                                  gapPadding: 113),
                                              contentPadding: EdgeInsets.only(
                                                  top: 4, left: 6),
                                              // labelText: 'Label',
                                              hintText: 'Enter phone number'
                                              // height: 60, // Set the height of the text field
                                              ),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )
                                  : Spacer(),
                              editPhone == true
                                  ? SizedBox()
                                  : Text(
                                      snapshot.data!['Phone_Number'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                              SizedBox(
                                width: 5,
                              ),
                              editPhone == true
                                  ? Row(
                                      children: [
                                        AppWidgets().myElevatedBTN(
                                          loading: loading1,
                                          onPressed: () {
                                            if (_editPhone.text
                                                .trim()
                                                .isNotEmpty) {
                                              setState(() {
                                                loading1 = true;
                                                _validate = false;
                                              });
                                              _firebaseFireStore
                                                  .collection('users')
                                                  .doc(_currentUser!.uid)
                                                  .update({
                                                'Phone_Number': _editPhone.text
                                                    .toString()
                                                    .trim()
                                              }).then((value) {
                                                setState(() {
                                                  editPhone = false;
                                                  loading1 = false;
                                                });
                                              }).onError((error, stackTrace) {
                                                Utils.flutterToast(
                                                    error.toString());
                                                setState(() {
                                                  loading1 = false;
                                                });
                                              });
                                            } else {
                                              setState(() {
                                                _validate = true;
                                              });
                                            }
                                          },
                                          btnWith: 44.0,
                                          btnColor: Colors.blue,
                                          btnHeight: 35.0,
                                          btnText: 'Update',
                                        ),
                                        // IconButton(
                                        //     onPressed: () {},
                                        //     icon: Icon(Icons.cancel_outlined))
                                      ],
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          editPhone = true;
                                        });
                                      },
                                      icon: Icon(Icons.edit))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Address:  ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              editAddress
                                  ? Expanded(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: _validate2 ? 49 : 35,
                                              child: TextField(
                                                controller: _editAddress,
                                                // keyboardType:
                                                //     TextInputType.number,
                                                decoration: InputDecoration(
                                                    errorText: _validate2
                                                        ? 'Enter Address'
                                                        : null,
                                                    alignLabelWithHint: false,
                                                    border: OutlineInputBorder(
                                                        gapPadding: 113),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 4, left: 6),
                                                    // labelText: 'Label',
                                                    hintText: 'Enter Address'
                                                    // height: 60, // Set the height of the text field
                                                    ),
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          AppWidgets().myElevatedBTN(
                                            loading: loading2,
                                            onPressed: () {
                                              if (_editAddress.text
                                                  .trim()
                                                  .isNotEmpty) {
                                                setState(() {
                                                  _validate2 = false;
                                                  loading2 = true;
                                                });
                                                _firebaseFireStore
                                                    .collection('users')
                                                    .doc(_currentUser!.uid)
                                                    .update({
                                                  'Address': _editAddress.text
                                                      .toString()
                                                      .trim()
                                                }).then((value) {
                                                  setState(() {
                                                    editAddress = false;
                                                    loading2 = false;
                                                  });
                                                }).onError((error, stackTrace) {
                                                  Utils.flutterToast(
                                                      error.toString());
                                                  setState(() {
                                                    loading2 = false;
                                                  });
                                                });
                                              } else {
                                                setState(() {
                                                  _validate2 = true;
                                                });
                                              }
                                            },
                                            btnWith: 44.0,
                                            btnColor: Colors.blue,
                                            btnHeight: 35.0,
                                            btnText: 'Update',
                                          ),
                                        ],
                                      ),
                                    )
                                  : Flexible(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              snapshot.data!['Address']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  editAddress = true;
                                                });
                                              },
                                              icon: Icon(Icons.edit))
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              SizedBox(
                height: 22,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    changeColor2 = false;

                    changeColor1 = !changeColor1;
                  });
                },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: changeColor1
                          ? Colors.greenAccent
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Icons.payments_outlined),
                        Text('Pay through cash on delivery'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    changeColor1 = false;
                    changeColor2 = !changeColor2;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DebitCardScreen()));
                },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: changeColor2
                          ? Colors.greenAccent
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Icons.payments_outlined),
                        Text('Pay with Debit Card               '),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 190,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Price: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Rs.${widget.productPrice}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Shipping: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Rs.${widget.productShippingPrice}'),
                ],
              ),
              SizedBox(
                height: 11,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'Rs.${widget.productShippingPrice! + widget.productPrice!}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              AppWidgets().myElevatedBTN(
                  loading: loading,
                  onPressed: () async {
                    if (changeColor2 == true || changeColor1 == false) {
                      Utils.flutterToast('Please Select Cash on delivery');
                    } else {
                      setState(() {
                        loading = true;
                      });
                      await _firebaseFireStore
                          .collection(widget.productCollectionName.toString())
                          .doc(widget.productUid.toString())
                          .update({
                        "productSold": true,
                        "productBuyer": _currentUser!.uid.toString(),
                        "BuyerEmail": _currentUser!.email.toString(),
                        "BuyerName": _currentUser!.displayName.toString(),
                        "BuyerPhoneNumber": phoneNumber,
                        "BuyerAddress": address,
                        "Accepted": '',
                      }).then((value) {
                        print(
                            '***************** ${widget.productUid.toString()} ***************** ');
                      });

                      _firebaseFireStore
                          .collection("Cart")
                          .doc(_currentUser!.uid.toString())
                          .collection("YourCart")
                          .doc(widget.productUid)
                          .update({
                        'pleaseWait': 'To Ship',
                        // 'SellerStatus': 'false',
                      }).then((value) {
                        Utils.flutterToast('Thanks! please wait to ship');
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: AlertDialog(
                                  icon: Icon(
                                    Icons.done_rounded,
                                    color: Colors.green,
                                    size: 33,
                                  ),
                                  title: const Text('Congratulations!!'),
                                  content: const Text(
                                      'Yor payment has been confirmed'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ShippingTabBar(
                                                        iniIndex: 2)));
                                      },
                                      child: Text('Ok'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CustomNavigationBar()));
                                      },
                                      child: Text('Continiue Shopping'),
                                    ),
                                  ],
                                ),
                              );
                            });
                        setState(() {
                          loading = false;
                        });
                      }).onError((error, stackTrace) {
                        setState(() {
                          loading = false;
                        });
                        Utils.flutterToast(error.toString());
                      });
                      print(
                          '***************** ${widget.productUid.toString()}');
                    }
                  },
                  btnText: 'Confirm Payment',
                  btnColor: Colors.blue)
            ],
          ),
        ),
      ),
    );
  }
}

///***********************************************************************
///***********************************************************************
///***********************************************************************
///***********************    Debit Card Screen   ************************
///***********************************************************************
///***********************************************************************
///***********************************************************************

class DebitCardScreen extends StatefulWidget {
  DebitCardScreen({Key? key}) : super(key: key);

  @override
  State<DebitCardScreen> createState() => _DebitCardScreenState();
}

class _DebitCardScreenState extends State<DebitCardScreen> {
  final TextEditingController _cvcController = TextEditingController();

  final TextEditingController _expiryController = TextEditingController();

  final TextEditingController _cardNumberController = TextEditingController();

  var myFormKey = GlobalKey<FormState>();

  bool waiting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Online Payment'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Form(
          key: myFormKey,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              AppWidgets().myTextFormField(
                fillColor: Colors.grey.shade400,
                labelColor: Colors.black,
                borderSideColor: Colors.black,
                hintColor: Colors.grey.shade700,
                textColor: Colors.black,
                hintText: 'Enter your Card Number',
                myType: TextInputType.number,
                labelText: 'Card Number',
                controller: _cardNumberController,
                validator: (String? txt) {
                  // bool emailValid =
                  //     RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                  //         .hasMatch(txt!);
                  if (txt == null || txt.isEmpty) {
                    return "Please provide your Card Number";
                  }
                  if (txt.length == 16) {
                    return null;
                  }
                  return "Your Card Number is Wrong";
                },
              ),
              SizedBox(
                height: 11,
              ),
              AppWidgets().myTextFormField(
                fillColor: Colors.grey.shade400,
                labelColor: Colors.black,
                borderSideColor: Colors.black,
                hintColor: Colors.grey.shade700,
                textColor: Colors.black,
                hintText: 'dd/mm/yy',
                myType: TextInputType.datetime,
                labelText: 'Card Expiry',
                controller: _expiryController,
                validator: (String? txt) {
                  // bool emailValid =
                  //     RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                  //         .hasMatch(txt!);
                  if (txt == null || txt.isEmpty) {
                    return "Please provide Card Expiry";
                  }
                  if (txt.length == 6) {
                    return null;
                  }
                  if (txt.length == 8) {
                    return null;
                  }
                  return "Your Card Expiry is Wrong";
                },
              ),
              SizedBox(
                height: 11,
              ),
              AppWidgets().myTextFormField(
                fillColor: Colors.grey.shade400,
                labelColor: Colors.black,
                borderSideColor: Colors.black,
                hintColor: Colors.grey.shade700,
                textColor: Colors.black,
                hintText: 'Enter CVC Number',
                myType: TextInputType.number,
                labelText: 'Card CVC',
                controller: _cvcController,
                validator: (String? txt) {
                  // bool emailValid =
                  //     RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                  //         .hasMatch(txt!);
                  if (txt == null || txt.isEmpty) {
                    return "Please provide Card CVC Number";
                  }
                  if (txt.length == 3) {
                    return null;
                  }
                  return "Your Card CVC Number is Wrong";
                },
              ),
              Spacer(),
              AppWidgets().myElevatedBTN(
                  loading: waiting,
                  onPressed: () async {
                    if (myFormKey.currentState!.validate()) {
                      setState(() {
                        waiting = true;
                      });
                      await Future.delayed(Duration(seconds: 3));
                      Navigator.pop(context);
                      Utils.flutterToast('Sorry, Process is Denied');
                    }
                  },
                  btnText: 'Submit')
            ],
          ),
        ),
      ),
    );
  }
}
