import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/utils/utils.dart';

class ReportPage extends StatefulWidget {
  String? sellerUid;
  ReportPage({required this.sellerUid, Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _firebaseInstance = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance.currentUser;

  bool btn = false;

  final TextEditingController _reportController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(44.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Write your Report',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              AppWidgets().myTextFormField(
                  hintText: 'Please Write a Report',
                  labelText: 'Report',
                  controller: _reportController,
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

                      await _firebaseInstance
                          .collection("Reports")
                          .doc(_firebaseAuth!.uid.toString())
                          .set({
                        'Reporter_Uid': _firebaseAuth!.uid.toString(),
                        'Seller_Uid': widget.sellerUid.toString(),
                        'User_Report': _reportController.text.toString(),
                        'User_Nik_Name': _nameController.text.toString(),
                        'Report_Timing': DateTime.now().toString(),
                        'Report_Timing_In_Milliseconds':
                            DateTime.now().millisecondsSinceEpoch.toString(),
                        'Report_Timing_String':
                            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                      }).then((value) async {
                        await _firebaseInstance
                            .collection("users")
                            .doc(_firebaseAuth!.uid)
                            .collection('Reports')
                            .doc(widget.sellerUid)
                            .set({
                          'Seller_Uid': widget.sellerUid.toString(),
                          'User_Uid': _firebaseAuth!.uid.toString(),
                          'User_Email': _firebaseAuth!.email,
                          'User_Review': _reportController.text.toString(),
                          'User_Name': _nameController.text.toString(),
                          // 'My_Review_Rating': review,
                          'Report_Timing': DateTime.now().toString(),
                          'Report_Timing_In_Milliseconds':
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          'Report_Timing_String':
                              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                        });
                        setState(() {
                          btn = false;
                        });
                        Utils.flutterToast('Thanks for Report');
                        Navigator.pop(context);
                      }).onError((error, stackTrace) {
                        Utils.flutterToast(error.toString());
                      });
                    },
                    child: btn == false
                        ? Text('   Submit Report   ')
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
