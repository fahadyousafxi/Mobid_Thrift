import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/Product_page.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

import '../constants/App_colors.dart';

class ViewMorePage extends StatefulWidget {
  const ViewMorePage({Key? key}) : super(key: key);

  @override
  State<ViewMorePage> createState() => _ViewMorePageState();
}

class _ViewMorePageState extends State<ViewMorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().myAppBar(context),
      drawer: MyAppbar().myDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.filter_list),
              color: AppColors.myIconColor,
            ),
            Center(child: AppWidgets().myHeading1Text('Phones')),
            SizedBox(height: 8,),
            Expanded(
              child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250, mainAxisSpacing: 8, crossAxisSpacing: 10),
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              SizedBox(

                                height: 112,
                                child: Image(
                                  // The Data will be loaded from firebse
                                  image: AssetImage("assets/images/phone.png"),
                                  // fit: BoxFit.cover,
                                ),
                              ),
                              AppWidgets().myHeading2Text('Product name'),
                              SizedBox(height: 8,),
                              Text('First line of discription'),
                              Text('Rs.400 is current bid '),
                              Text('1 Day time left '),
                              SizedBox(height: 22,)
                            ],
                          ),
                        )
                    ),
                  ),



                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              SizedBox(

                                height: 112,
                                child: Image(
                                  // The Data will be loaded from firebse
                                  image: AssetImage("assets/images/phone.png"),
                                  // fit: BoxFit.cover,
                                ),
                              ),
                              AppWidgets().myHeading2Text('Product name'),
                              SizedBox(height: 8,),
                              Text('First line of discription'),
                              Text('Rs.400 is current bid '),
                              Text('1 Day time left '),
                            ],
                          ),
                        )
                    ),
                  ),




                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              SizedBox(

                                height: 112,
                                child: Image(
                                  // The Data will be loaded from firebse
                                  image: AssetImage("assets/images/phone.png"),
                                  // fit: BoxFit.cover,
                                ),
                              ),
                              AppWidgets().myHeading2Text('Product name'),
                              SizedBox(height: 8,),
                              Text('First line of discription'),
                              Text('Rs.400 is current bid '),
                              Text('1 Day time left '),
                            ],
                          ),
                        )
                    ),
                  ),





                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              SizedBox(

                                height: 112,
                                child: Image(
                                  // The Data will be loaded from firebse
                                  image: AssetImage("assets/images/phone.png"),
                                  // fit: BoxFit.cover,
                                ),
                              ),
                              AppWidgets().myHeading2Text('Product name'),
                              SizedBox(height: 8,),
                              Text('First line of discription'),
                              Text('Rs.400 is current bid '),
                              Text('1 Day time left '),
                            ],
                          ),
                        )
                    ),
                  ),






                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              SizedBox(

                                height: 112,
                                child: Image(
                                  // The Data will be loaded from firebse
                                  image: AssetImage("assets/images/phone.png"),
                                  // fit: BoxFit.cover,
                                ),
                              ),
                              AppWidgets().myHeading2Text('Product name'),
                              SizedBox(height: 8,),
                              Text('First line of discription'),
                              Text('Rs.400 is current bid '),
                              Text('1 Day time left '),
                              SizedBox(height: 22,)
                            ],
                          ),
                        )
                    ),
                  ),



                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              SizedBox(

                                height: 112,
                                child: Image(
                                  // The Data will be loaded from firebse
                                  image: AssetImage("assets/images/phone.png"),
                                  // fit: BoxFit.cover,
                                ),
                              ),
                              AppWidgets().myHeading2Text('Product name'),
                              SizedBox(height: 8,),
                              Text('First line of discription'),
                              Text('Rs.400 is current bid '),
                              Text('1 Day time left '),
                            ],
                          ),
                        )
                    ),
                  ),




                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              SizedBox(

                                height: 112,
                                child: Image(
                                  // The Data will be loaded from firebse
                                  image: AssetImage("assets/images/phone.png"),
                                  // fit: BoxFit.cover,
                                ),
                              ),
                              AppWidgets().myHeading2Text('Product name'),
                              SizedBox(height: 8,),
                              Text('First line of discription'),
                              Text('Rs.400 is current bid '),
                              Text('1 Day time left '),
                            ],
                          ),
                        )
                    ),
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
