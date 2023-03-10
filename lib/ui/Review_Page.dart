import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/utils/utils.dart';

class ReviewPage extends StatefulWidget {
  double? reviews;
  int? totalNoOfReviews;
  String? uId;
  ReviewPage(
      {required this.reviews,
      required this.totalNoOfReviews,
      required this.uId,
      Key? key})
      : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _firebaseInstance =
      FirebaseFirestore.instance.collection("SellerCenterUsers");
  final _firebaseAuth = FirebaseAuth.instance.currentUser;

  bool btn = false;

  bool star1 = true;
  bool star2 = false;
  bool star3 = false;
  bool star4 = false;
  bool star5 = false;

  int review = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              height: 44,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 66.0, right: 66),
              child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      btn = true;
                    });
                    double a =
                        review + double.parse(widget.reviews!.toString());
                    int b = widget.totalNoOfReviews! + 1;
                    double reviews = a / 2;

                    await _firebaseInstance.doc(widget.uId).update({
                      'Total_Number_of_Reviews': widget.totalNoOfReviews! + 1,
                      'Total_Review_Rating': reviews,
                    }).then((value) {
                      setState(() {
                        btn = false;
                      });
                      Utils.flutterToast('Thanks for Review');
                      Navigator.pop(context);
                    }).onError((error, stackTrace) {
                      Utils.flutterToast(error.toString());
                    });

                    // _firebaseInstance
                    //     .doc(widget.uId)
                    //     .collection('Reviews')
                    //     .doc(_firebaseAuth!.uid)
                    //     .update({
                    //   'User_Uid': _firebaseAuth!.uid.toString(),
                    //   'My_Review_Rating': review,
                    // }).then((value) {
                    //   setState(() {
                    //     btn = false;
                    //   });
                    //   Utils.flutterToast('Thanks for Review');
                    // });
                  },
                  child: btn == false
                      ? Text('   Submit Review   ')
                      : Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )),
            )
          ],
        ),
      ),
    );
  }
}
