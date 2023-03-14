import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Testings extends StatefulWidget {
  const Testings({Key? key}) : super(key: key);

  @override
  State<Testings> createState() => _TestingsState();
}

class _TestingsState extends State<Testings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Accessories')
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: EdgeInsets.all(4),
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.all(3),
                                child: Column(
                                  children: [
                                    Text(snapshot.data!.docs[index]
                                        .get('myList2')[2]
                                        .toString()),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs[index]
                                          .get('myList2')
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int index2) {
                                        return Text(snapshot.data!.docs[index]
                                            .get('myList2')[index2]
                                            .toString());
                                      },
                                    )
                                  ],
                                ));
                          }),
                    );
            },
          ),
        ],
      ),
    );
  }
}



//
// ElevatedButton(onPressed: (){
//
// List<String> listData = ['list Data 1 Data', 'list Data 2', 'list Data 3 Data', 'list Data 4'];
//
// FirebaseFirestore.instance.collection(widget.productCollectionName.toString()).doc(widget.productUid.toString()).update({
// 'TheList' : listData,
// }).then((value) {            print("           done            ok");
// });
//
// print(widget.productUid);
// print(widget.productCollectionName);
// }, child: Text('cheking')),




// FutureBuilder<DocumentSnapshot>(
// future: FirebaseFirestore.instance.collection(widget.productCollectionName.toString()).doc(widget.productUid.toString()).get(),
// builder: (BuildContext context,
// AsyncSnapshot<DocumentSnapshot> snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting)
// return Center(
// child: CircularProgressIndicator(
// color: Colors.blue,
// ));
//
// if (snapshot.hasError) return Center(child: Text('Some Error'));
//
// return ListView.builder(
// shrinkWrap: true,
// itemCount: snapshot.data!['TheList'].length,
// itemBuilder: (BuildContext context, int index) {
// return Text(snapshot.data!['TheList'][index]);
// },);
// }),