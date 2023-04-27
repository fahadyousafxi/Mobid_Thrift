import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/utils/utils.dart';

class ReviewPage extends StatefulWidget {
  double? reviews;
  int? totalNoOfReviews;
  String? sellerUid;
  ReviewPage(
      {required this.reviews,
      required this.totalNoOfReviews,
      required this.sellerUid,
      Key? key})
      : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _firebaseInstance = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance.currentUser;

  bool btn = false;

  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool star1 = true;
  bool star2 = false;
  bool star3 = false;
  bool star4 = false;
  bool star5 = false;

  int review = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(44.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Give a Review'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        star2 = false;
                        star3 = false;
                        star4 = false;
                        star5 = false;
                        setState(() {
                          review = 1;
                        });
                      },
                      icon: Icon(
                        Icons.star,
                        color: star1 == false ? Colors.grey : Colors.amber,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          star2 = true;
                          star3 = false;
                          star4 = false;
                          star5 = false;
                          review = 2;
                        });
                      },
                      icon: Icon(
                        Icons.star,
                        color: star2 == false ? Colors.grey : Colors.amber,
                      )),
                  IconButton(
                      onPressed: () {
                        star2 = true;
                        star3 = true;
                        star4 = false;
                        star5 = false;
                        review = 3;

                        setState(() {});
                      },
                      icon: Icon(
                        Icons.star,
                        color: star3 == false ? Colors.grey : Colors.amber,
                      )),
                  IconButton(
                      onPressed: () {
                        star2 = true;
                        star3 = true;
                        star4 = true;
                        star5 = false;
                        review = 4;

                        setState(() {});
                      },
                      icon: Icon(
                        Icons.star,
                        color: star4 == false ? Colors.grey : Colors.amber,
                      )),
                  IconButton(
                      onPressed: () {
                        star2 = true;
                        star3 = true;
                        star4 = true;
                        star5 = true;
                        review = 5;

                        setState(() {});
                      },
                      icon: Icon(
                        Icons.star,
                        color: star5 == false ? Colors.grey : Colors.amber,
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              AppWidgets().myTextFormField(
                  hintText: 'Please Write a Review',
                  labelText: 'Review',
                  controller: _reviewController,
                  hintColor: Colors.black38,
                  labelColor: Colors.black,
                  textColor: Colors.black,
                  fillColor: Colors.black12),
              SizedBox(
                height: 15,
              ),
              AppWidgets().myTextFormField(
                  hintText: 'Please Write Your Name',
                  labelText: 'Name',
                  controller: _nameController,
                  hintColor: Colors.black38,
                  labelColor: Colors.black,
                  textColor: Colors.black,
                  fillColor: Colors.black12),
              SizedBox(
                height: 44,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 66.0, right: 66),
                child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        btn = true;
                      });
                      double reviews;
                      double a = review + widget.reviews!;
                      int b = widget.totalNoOfReviews! + 1;
                      if (b <= 1) {
                        reviews = a / b;
                      } else {
                        reviews = a / 2;
                      }
                      // print(
                      //     '#################################### checking #####################');
                      // print(a);
                      // print(b);
                      // print(reviews);
                      // print(review);

                      await _firebaseInstance
                          .collection("SellerCenterUsers")
                          .doc(widget.sellerUid)
                          .update({
                        'Total_Number_of_Reviews': widget.totalNoOfReviews! + 1,
                        'Total_Review_Rating': reviews,
                      }).then((value) async {
                        await _firebaseInstance
                            .collection("users")
                            .doc(_firebaseAuth!.uid.toString())
                            .collection('Reviews')
                            .doc(widget.sellerUid)
                            .set({
                          'User_Uid': widget.sellerUid.toString(),
                          'User_Email': _firebaseAuth!.email,
                          'User_Review': _reviewController.text.toString(),
                          'User_Name': _nameController.text.toString(),
                          'My_Review_Rating': review,
                          'Review_Timing': DateTime.now().toString(),
                          'Review_Timing_In_Milliseconds':
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          'Review_Timing_String':
                              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                        });
                        await _firebaseInstance
                            .collection("SellerCenterUsers")
                            .doc(widget.sellerUid)
                            .collection('Reviews')
                            .doc(_firebaseAuth!.uid)
                            .set({
                          'User_Uid': _firebaseAuth!.uid.toString(),
                          'User_Email': _firebaseAuth!.email,
                          'User_Review': _reviewController.text.toString(),
                          'User_Name': _nameController.text.toString(),
                          'My_Review_Rating': review,
                          'Review_Timing': DateTime.now().toString(),
                          'Review_Timing_In_Milliseconds':
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          'Review_Timing_String':
                              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                        });
                        setState(() {
                          btn = false;
                        });
                        Utils.flutterToast('Thanks for Review');
                        Navigator.pop(context);
                      }).onError((error, stackTrace) {
                        Utils.flutterToast(error.toString());
                      });
                    },
                    child: btn == false
                        ? Text('   Submit Review   ')
                        : Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )),
              ),
              // ElevatedButton(onPressed: (){
              //   print(object);
              // }, child: Text('check'))
            ],
          ),
        ),
      ),
    );
  }
}
