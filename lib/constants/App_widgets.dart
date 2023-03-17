import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobidthrift/ui/Product_page.dart';
import 'package:timer_count_down/timer_count_down.dart';

class AppWidgets {
  /// My Elevated Button
  Widget myElevatedBTN(
      {required var onPressed,
      required var btnText,
      final bool loading = false,
      Color btnColor = Colors.black,
      var btnWith = 200.0,
      var btnHeight = 40.0}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        minimumSize: Size(btnWith, btnHeight),
      ),
      child: loading == true
          ? const CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.white,
            )
          : Text(btnText),
    );
  }

  /// My TextFormField
  Widget myTextFormField(
      {required var hintText,
      required var labelText,
      required TextEditingController controller,
      TextInputType myType = TextInputType.text,
      bool obscureText = false,
      String? Function(String?)? validator,
      Color textColor = Colors.white,
      Color enBorderSideColor = Colors.white12,
      Color borderSideColor = Colors.red,
      var enBorderRadius = 20.0,
      var borderRadius = 20.0,
      Color fillColor = Colors.white12,
      Color hintColor = Colors.white38,
      Color labelColor = Colors.white70}) {
    return TextFormField(
      keyboardType: myType,
      obscureText: obscureText,
      validator: validator,
      controller: controller,
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
        labelStyle: TextStyle(color: labelColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderSideColor, width: 2.0),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  /// My Text Form Field
  Widget myTextField(
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
    return TextField(
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
        labelStyle: TextStyle(color: labelColor),
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
      margin: const EdgeInsets.only(left: 0, bottom: 0, right: 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: Colors.black,
        ),
        color: Colors.white,
      ),
      height: height,
      child: const Image(
        // The Data will be loaded from firebse
        image: AssetImage("assets/images/adbanner.png"),
        // fit: BoxFit.cover,
      ),
    );
  }

  /// Home Screen Category row
  Widget categoryRow(
      {required var categoryText,
      required var textButtonText,
      required var onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          categoryText,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              textButtonText,
              style: const TextStyle(fontSize: 16),
            )),
      ],
    );
  }

  /// My Texts
  Widget myHeading1Text(String txt, {Color color = Colors.black}) {
    return Text(
      txt,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
    );
  }

  Widget myHeading2Text(String txt, {Color color = Colors.black}) {
    return Text(
      txt,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
    );
  }

  Widget myNormalText(String txt) {
    return Text(
      txt,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black),
    );
  }

  /// Count Down Widgets
  int _countTime = 0;
  int _countDownTime = 0;
  var f = NumberFormat('00', 'en_US');
  Widget countDownTimer(var endTime) {
    // _countdownController.start();
    _countTime = endTime - (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    if (_countTime > 0) {
      _countDownTime = _countTime;
    } else {
      _countDownTime = 0;
    }
    print(_countDownTime);
    return Countdown(
      // controller: _countdownController,
      seconds: _countDownTime,
      build: (BuildContext context, double time) => Text(
          '${(time ~/ 86400)}Days  ${f.format((time % 86400) ~/ 3600)}:${f.format((time % 3600) ~/ 60)}:${f.format(time.toInt() % 60)} Time Left'),
      interval: Duration(seconds: 1),
      onFinished: () {
        debugPrint('#######################  ok  #################');
      },
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductPage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: const [
                    SizedBox(
                      height: 112,
                      child: Image(
                        // The Data will be loaded from firebse
                        image: AssetImage("assets/images/phone.png"),
                        // fit: BoxFit.cover,
                      ),
                    ),
                    Text('Product name'),
                    Text('First line of discription'),
                    Text('Rs.400  is current bid '),
                    Text('1 Day time left '),
                  ],
                ),
              )),
        ),

        const SizedBox(
          width: 10,
        ),

        Card(
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.0),
          ),
          child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductPage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: const [
                    SizedBox(
                      height: 112,
                      child: Image(
                        // The Data will be loaded from firebse
                        image: AssetImage("assets/images/phone.png"),
                        // fit: BoxFit.cover,
                      ),
                    ),
                    Text('Iphone 14'),
                    Text('First line of discription'),
                    Text('Rs.900 is current bid '),
                    Text('2 Day time left '),
                  ],
                ),
              )),
        ),

        const SizedBox(
          width: 10,
        ),

        Card(
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.0),
          ),
          child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductPage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: const [
                    SizedBox(
                      height: 112,
                      child: Image(
                        // The Data will be loaded from firebse
                        image: AssetImage("assets/images/phone.png"),
                        // fit: BoxFit.cover,
                      ),
                    ),
                    Text('Iphone 14 Pro Max'),
                    Text('First line of discription'),
                    Text('Rs.1000 is current bid '),
                    Text('1 Day time left '),
                  ],
                ),
              )),
        ),
        // Container(
        //   padding: EdgeInsets.all(5.0),
        //   margin: EdgeInsets.only(left: 0, bottom: 0, right: 0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(20)),
        //     border: Border.all(
        //       color: Colors.black,
        //     ),
        //     color: Colors.white,
        //   ),
        //   height: 22,
        //   child: Image(
        //     // The Data will be loaded from firebse
        //     image: AssetImage("assets/images/phone.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // SizedBox(
        //   width: 10,
        // ),
        // Container(
        //   padding: EdgeInsets.all(5.0),
        //   margin: EdgeInsets.only(left: 0, bottom: 0, right: 0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(20)),
        //     border: Border.all(
        //       color: Colors.black,
        //     ),
        //     color: Colors.white,
        //   ),
        //   height: 222,
        //   child: Image(
        //     // The Data will be loaded from firebse
        //     image: AssetImage("assets/images/phone.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
      ],
    );
  }
}
