

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';

class MyOrderDetailPage extends StatefulWidget {
  const MyOrderDetailPage({super.key});

  @override
  State<MyOrderDetailPage> createState() => _MyOrderDetailPageState();
}

class _MyOrderDetailPageState extends State<MyOrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    int currentstep = 0;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actionsIconTheme: const IconThemeData(size: 10),
        title:
            const Text("Order Details", style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {},
            child: Image.asset(
              'assests/images/Vector.png',
              height: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: InkWell(
              onTap: () {},
              child: Image.asset('assests/images/appbarnoti.png'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Container(
                // height: 100,
                width: MediaQuery.of(context).size.width / 1.05,
                height: 140,
                // color: Colors.amber,
                child: Row(
                  children: [
                    Container(
                      // height: 100,
                      width: MediaQuery.of(context).size.width / 1.6,
                      // color: Colors.amber,
                      padding: const EdgeInsets.only(left: 7, top: 11),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                constraints: const BoxConstraints(
                                    minHeight: 0, maxHeight: 50),
                                margin: const EdgeInsets.only(bottom: 1),
                                // color: Colors.amber,
                                width: MediaQuery.of(context).size.width / 2,
                                child: const AutoSizeText(
                                  'The boy shirt',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    minHeight: 0,
                                    minWidth: 0,
                                    maxWidth:
                                        MediaQuery.of(context).size.width / 1.8,
                                    maxHeight: 60),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    'men maroon all printed shirtmen maroon all printed shirtmen maroon all printed shirt',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Text('Size: M',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 92, 92, 92),
                                  ))
                            ],
                          ),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, top: 5),
                                child: Text(
                                  '₹100',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 92, 92, 92)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(23.0),
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(45),
                          child: Image.asset(
                            "assests/images/smile.jpg",
                            // height: 90,
                            // width: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              // Container(height: 50,width: 50,color: Colors.amber,)
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, top: 25),
                    // margin:  EdgeInsets.only(right: MediaQuery.of(context).size.width/2,top: 5),
                    height: 200, width: 5, color: Colors.grey,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 22),
                    child: Column(
                      children: [
                        StatusWidget(
                            "Order Confirmed", true, 'Sun, 3rd Oct 22'),
                        StatusWidget("Shipped ", true, 'Sun, 4rd Oct 22'),
                        StatusWidget("Out for Delivery", true, 'Sun, 4rd Oct 22'),

                        
                        StatusWidget("Delivered", false, 'Yet to Deliver'),
                        const SizedBox(height:20,)
                      ],
                    ),
                  )
                ],
              ),
              // const Divider(),
              Container(
                height: 8,
                decoration: const BoxDecoration(
                color:  Color.fromARGB(255, 238, 238, 238),
                  
                  boxShadow: [
                  BoxShadow(
                     color: Colors.grey,
                      offset:  Offset(1.2 , 0),
                      blurRadius:1,
                      spreadRadius: 0,
                  )
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 40,
                child: Row(
                  children: const [
                    Icon(
                      Icons.receipt,
                      color: Colors.green,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Download Invoice',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),

              // const Divider(),
              Container(
                height: 8,
                decoration: const BoxDecoration(
                color:  Color.fromARGB(255, 238, 238, 238),
                  
                  boxShadow: [
                  BoxShadow(
                     color: Colors.grey,
                      offset:  Offset(1.2 , 0),
                      blurRadius:1,
                      spreadRadius: 0,
                  )
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 30,
                margin:const  EdgeInsets.only(top: 5),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Shipping Detail',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              const Divider(),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only( bottom: 5),
                      child: Text(
                        'Abhishek Abhishek',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                     SizedBox(

                        // color: Colors.amber,
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: const Text(
                            'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnoprqrstuvwxys ')),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Text('Mumbai'),
                    ),
                    const Text('Maharashtra - 400086'),
                    const Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 10),
                      child: Text('Mobile no: 1342342341'),
                    ),
                  ],
                ),
              ),
              // Divider()
              Container(
                height: 8,
                decoration: const BoxDecoration(
                color:  Color.fromARGB(255, 238, 238, 238),
                  
                  boxShadow: [
                  BoxShadow(
                     color: Colors.grey,
                      offset:  Offset(1.2 , 0),
                      blurRadius:1,
                      spreadRadius: 0,
                  )
                ]),
              ),
              Container(
                margin:const  EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width / 1.1,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Shipping Detail',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              const Divider(),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,

                  child: Column(
                    children: [
                      Row(children: const [
                        Text('Actual Price'),Spacer(),Text('₹300')
                      ],),
                      Row(children: const [
                        Text('Discounted Price'),Spacer(),Text('₹100')
                      ],),
                      Row(children: const [
                        Text('Shipping fee'),Spacer(),Text('₹50')
                      ],),
                      Row(children: const [
                        Text('Special price'),Spacer(),Text('₹50')
                      ],),
                     const  SizedBox(height: 5,),
                      const DottedLine(
                              dashLength: 4,
                              dashGapLength:2,
                              dashColor: Colors.grey,
                              
                            ),
                     const  SizedBox(height: 5,),
                      Row(children: const [
                        Text('Total Price', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16),),Spacer(),Text('₹200',style: TextStyle(fontWeight: FontWeight.bold,fontSize:16)),

                      ],),
                       const SizedBox(height:10,),

                    ],
                  ),
              ),
              Container(
                height: 8,
                decoration: const BoxDecoration(
                color:  Color.fromARGB(255, 238, 238, 238),
                  
                  boxShadow: [
                  BoxShadow(
                     color: Colors.grey,
                      offset:  Offset(1.2 , 0),
                      blurRadius:1,
                      spreadRadius: 0,
                  )
                ]),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  Container StatusWidget(String stasus, bool isActive, String date) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      
      child: Row(
        children: [
          Container(
            height: 20,
            width: 020,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive == true ? Colors.green : Colors.white,
                border: Border.all(
                    color: isActive == true ? Colors.transparent : Colors.green,
                    width: 3)),
          ),
          Container(
              margin: EdgeInsets.only(left: 15, top: 10),
              padding: EdgeInsets.only(top: 15),
              height: 55,
              width: MediaQuery.of(context).size.width / 2.3,

              // color: Colors.amber,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(stasus),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
// List<Step> steps=[

//   Step(title: Text("Tesitng 1"), content: Icon(Icons.add)),
//   Step(title: Text("Tesitng2"), content: Icon(Icons.add))
// ,  Step(title: Text("Tesitng3"), content: Icon(Icons.add))
// ,
// ];
