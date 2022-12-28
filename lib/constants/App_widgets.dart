
import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/Product_page.dart';

import 'App_colors.dart';

class AppWidgets {
  /// My Elevated Button
  Widget myElevatedBTN(
      {required var onPressed,
      required var btnText,
      Color btnColor = Colors.black,
      var btnWith = 200.0,
      var btnHeight = 40.0}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(btnText),
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        minimumSize: Size(btnWith, btnHeight),
      ),
    );
  }

  /// My Text Form Field
  Widget myTextFormField(
      {required var hintText,
      required var labelText,
      Color textColor = Colors.white,
      Color enBorderSideColor = Colors.white12,
      Color borderSideColor = Colors.red,
      var enBorderRadius = 20.0,
      var borderRadius = 20.0,
      Color fillColor = Colors.white12,
      Color hintColor = Colors.white38,
      Color labelColor = Colors.white70}) {
    return TextFormField(
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enBorderSideColor, width: 2.0),
          borderRadius: BorderRadius.circular(enBorderRadius),
        ),
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor),
        label: Text(labelText),
        labelStyle: new TextStyle(color: labelColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderSideColor, width: 2.0),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }


  /// My Add Banner Container
  Widget myAddBannerContainer({required var height}) {
    return Container(
      margin: EdgeInsets.only(left: 0, bottom: 0, right: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: Colors.black,
        ),
        color: Colors.white,
      ),
      height: height,
      child: Image(
        // The Data will be loaded from firebse
        image: AssetImage("assets/images/adbanner.png"),
        // fit: BoxFit.cover,
      ),
    );
  }

  /// Home Screen Category row
  Widget categoryRow({required var categoryText, required var textButtonText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          categoryText,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              textButtonText,
              style: TextStyle(fontSize: 16),
            )),
      ],
    );
  }

  /// My List view of Static data
  Widget myList(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.0),
          ),
          child: GestureDetector(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
            child: Column(
              children: [
                SizedBox(
                  height: 111,
                  child: Image(
                  // The Data will be loaded from firebse
                  image: AssetImage("assets/images/phone.png"),
                  // fit: BoxFit.cover,
                  ),
                ),
                Text('Product name'),
              ],
            )
          ),
        ),



        SizedBox(
          width: 10,
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.only(left: 0, bottom: 0, right: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Colors.black,
            ),
            color: Colors.white,
          ),
          height: 22,
          child: Image(
            // The Data will be loaded from firebse
            image: AssetImage("assets/images/phone.png"),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.only(left: 0, bottom: 0, right: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Colors.black,
            ),
            color: Colors.white,
          ),
          height: 222,
          child: Image(
            // The Data will be loaded from firebse
            image: AssetImage("assets/images/phone.png"),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
