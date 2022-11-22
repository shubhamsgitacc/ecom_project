

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce/pages/MyorderDetailPage.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
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
        title: const Text("Orders", style: TextStyle(color: Colors.green)),
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
        child: Center(
          child: Column(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.12,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrderDetailPage()));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        // height: 150,
                        // width: 100,
                        // color: Colors.amber,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(23.0),
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(60),
                                    child: Image.asset(
                                      "assests/images/smile.jpg",
                                      // height: 90,
                                      // width: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  // height: 100,
                                  width:
                                      MediaQuery.of(context).size.width / 2,
                                  // color: Colors.amber,
                                  padding:
                                      const EdgeInsets.only(left: 7, top: 11),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(
                                                minHeight: 0, maxHeight: 50),
                                            margin: const EdgeInsets.only(
                                                bottom: 1),
                                            // color: Colors.amber,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.1,
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
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                   2.3,
                                                maxHeight: 50),
                                            child:const Padding(
                                              padding:  EdgeInsets.only(bottom: 5,),
                                              child:  Text(
                                                'men maroon all printed shirtmen maroon all printed shirtmen maroon all printed shirt',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: const [Text('Size: M',style: TextStyle( color: Color.fromARGB(255, 92, 92, 92),))],
                                      ),
                                      Row(
                                        children:  const [
                                           Padding(
                                            padding: EdgeInsets.only(bottom: 5,top: 5),
                                            child: Text(
                                              '₹100',
                                              style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 92, 92, 92)),
                                            ),
                                          ),
                    
                    
                                        ],
                    
                    
                                      )
                                    ],
                                  ),
                                ),
                                          SizedBox(
                                            // height: 30,
                                            width: 20,
                                            // color: Colors.amber,
                                            child: Center(child: InkWell(onTap: (){}, child: const Icon(Icons.arrow_forward_ios_rounded,size: 18,))))
                    
                              ],
                            ),
                           const Divider(),
                            Row(
                              children: [
                                const Text('Delivering on 20 feb 2020'),
                                const Spacer(),
                                Container(
                                  height: 30,
                                  padding:const EdgeInsets.symmetric(horizontal: 3),
                                  
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),color: const Color.fromARGB(255, 240, 240, 160)),
                                  child:const Center(child:   Text('Pending',style: TextStyle(color: Color.fromARGB(255, 204, 184, 4)),)),
                                )
                              ],
                            ),
                            
                          ],
                          
                        ),
                      ),
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
