import 'package:flutter/material.dart';

import '../../constants/App_colors.dart';
import '../appbar/My_appbar.dart';
import 'add_product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'Select Product'),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              myBTN(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProduct(
                                  productCollectionName: 'CellPhonesProducts',
                                )));
                  },
                  btnText: 'Phones',
                  btnColor: AppColors.myRedColor),
              SizedBox(
                height: 22,
              ),
              myBTN(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProduct(
                                  productCollectionName:
                                      'PadsAndTabletsProducts',
                                )));
                  },
                  btnText: 'Pads & Tablets',
                  btnColor: AppColors.myRedColor),
              SizedBox(
                height: 22,
              ),
              myBTN(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProduct(
                                  productCollectionName: 'SmartWatches',
                                )));
                  },
                  btnText: 'Smart Watches',
                  btnColor: AppColors.myRedColor),
              SizedBox(
                height: 22,
              ),
              myBTN(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProduct(
                                  productCollectionName: 'LaptopsProducts',
                                )));
                  },
                  btnText: 'Laptops',
                  btnColor: AppColors.myRedColor),
              SizedBox(
                height: 22,
              ),
              myBTN(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProduct(
                                  productCollectionName: 'Desktops',
                                )));
                  },
                  btnText: 'Desktops',
                  btnColor: AppColors.myRedColor),
              SizedBox(
                height: 22,
              ),
              myBTN(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProduct(
                                  productCollectionName: 'Accessories',
                                )));
                  },
                  btnText: 'Accessories',
                  btnColor: AppColors.myRedColor),
              SizedBox(
                height: 22,
              ),
              myBTN(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProduct(
                                  productCollectionName: 'Parts',
                                )));
                  },
                  btnText: 'Parts',
                  btnColor: AppColors.myRedColor),
              SizedBox(
                height: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myBTN(
      {var loading, required btnText, required var onPressed, var btnColor}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(colors: [Colors.blue, Colors.red])),
        child: loading == true
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
            : Center(
                child: Text(
                btnText,
                style: TextStyle(color: Colors.white),
              )),
      ),
    );
  }
}
