import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/Seller_Profile.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {


  TextEditingController bidAmount = TextEditingController();
  var currentBid = 10.0;
  var myBid = 0.0;
  bool _validate = false;

  @override
  void dispose() {
    bidAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().myAppBar(context),
      drawer: MyAppbar().myDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 22,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SellerProfile()));
                    },
                    child: CircleAvatar(
                      radius: 33,
                      child: Icon(Icons.image),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SellerProfile()));
                          },
                          child:
                              AppWidgets().myHeading1Text("Shopkeeper's Name")),
                      Row(
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
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/phone.png',
                    height: 255,
                  ),
                  Text('Iphone'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 22, right: 22, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rs.${currentBid.toInt()} Current Bid'),
                            Text('Rs.${myBid.toInt()} your Bid'),
                            Text('4d 3h Time Left'),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('PTA Aproved'),
                                Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )
                              ],
                            ),
                            Text('Shipping: Rs.200'),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: _validate ? 49 : 35,
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: TextField(
                          controller: bidAmount,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(

                              errorText: _validate ? 'Your bid amount is low' : null,
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(gapPadding: 113),
                              contentPadding: EdgeInsets.only(top: 4, left: 6),
                              // labelText: 'Label',
                              hintText: 'Your Bid Amount'
                              // height: 60, // Set the height of the text field
                              ),
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      AppWidgets().myElevatedBTN(
                        btnWith: MediaQuery.of(context).size.width / 2.5,
                        btnHeight: 35.0,
                        onPressed: () {
                          double bid = double.parse(bidAmount.text.toString());
                          print(bid);
                          if(bid > currentBid ){
                            // bidAmount.text.isEmpty || bid < currentBid ? _validate = true : _validate = false;
                            _validate = false;
                            myBid = bid;

                            currentBid = bid;
                            setState(() {});
                          } else{
                            bidAmount.text.isEmpty || bid <= currentBid ? _validate = true : _validate = false;
                            setState(() {});
                          }
                            },
                        btnText: 'Bid',
                        btnColor: AppColors.buttonColorBlue,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppWidgets().myElevatedBTN(
                          btnWith: MediaQuery.of(context).size.width / 1,
                          btnHeight: 35.0,
                          onPressed: () {},
                          btnText: 'Buy it now: Rs.150000',
                          btnColor: AppColors.buttonColorBlue),
                      AppWidgets().myElevatedBTN(
                          btnWith: MediaQuery.of(context).size.width / 1,
                          btnHeight: 35.0,
                          onPressed: () {},
                          btnText: '❤ Add to wish list',
                          btnColor: AppColors.buttonColorBlue),
                      AppWidgets().myHeading2Text('Discription: '),
                      AppWidgets().myNormalText(
                          '     Discription about the product for example:  Divice is good'),
                      SizedBox(
                        height: 12,
                      ),
                      AppWidgets().myHeading2Text('Specification: '),
                      AppWidgets().myNormalText(
                          '     Specification of the product for example:  64GB - Black'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
