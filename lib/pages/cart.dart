import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:ecommerce/hive/hiveaddtocart.dart';
import 'package:ecommerce/hive/hivefav.dart';
import 'package:ecommerce/local%20storage/addtocar.dart';
import 'package:ecommerce/local%20storage/addtofav.dart';
import 'package:ecommerce/models/favmodel.dart';
import 'package:ecommerce/models/homepagemodel.dart' as model;
import 'package:ecommerce/pages/notification.dart';
import 'package:ecommerce/pages/slectaddress.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:ecommerce/pages/dlvrydate.dart';
import 'package:ecommerce/pages/home.dart';

import 'package:ecommerce/webservices/get.dart';

import 'package:flutter/material.dart';

import '../models/addtocartmodel.dart';
import '../widgets/itemcard.dart';

List iscarted = [];
int? itemscount;
int totalPrice = 0;

class Mycart extends StatefulWidget {
  const Mycart({super.key});

  @override
  State<Mycart> createState() => _MycartState();
}

List isfav = [];
FavModels? fav;
late Future<List<CartModels>> cartmodelsllist;

class _MycartState extends State<Mycart> {
  DbCartHandler? dbCartHandler;
  DbFAVHandlder? dbFAVHandlder;

  @override
  void initState() {
    super.initState();
    dbFAVHandlder = DbFAVHandlder();
    dbCartHandler = DbCartHandler();
    loadData();
  }

  Future getFav(int id) async {
    final favbox = FavBox.getFavBox();

    fav = favbox.get(id);

    return fav;
  }

  loadData() async {
    cartmodelsllist = dbCartHandler!.geCartList();
  }

  int totol = 0;

  int qnty = 1;
  @override
  Widget build(BuildContext context) {
    loadData();
// GeTApi();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Cart',
            style: TextStyle(
              fontSize: 23,
              color: Color.fromRGBO(0, 155, 55, 1),
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back,
                color: Color.fromRGBO(0, 155, 55, 1))),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const MyNoti())));
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                'assests/images/bellicn.png',
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Shipment of 1 of 1',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text('2 itmes', style: TextStyle(fontSize: 16))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: Color.fromARGB(19, 158, 158, 158))),
                // color: Colors.white,
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: const EdgeInsets.only(top: 18, left: 20),
                  child: const Text(
                    'Delivery in 15 min',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: AddtoCartBox.getCartBox().listenable(),
                  builder: (context, box, _) {
                    return box.values != null
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: box.values.length,
                            itemBuilder: (context, index) {
                              CartModels? res = box.getAt(index);
                              itemscount = box.values.length;
                              if (res != null) {
                                getFav(int.parse(res.id.toString()));
                                getCart(int.parse(res.id.toString()));
                              }
                              for (int i = 0; i <= box.values.length; i++) {
                                int price =
                                    int.parse(res!.actualprice.toString()) *
                                        int.parse(res.quantity.toString());

                                print(i);
                                print(price);
                                totol = price + totol;
                                print(totalPrice);
                                // totalPrice = price + totalPrice;
                                // print(price);
                                // print(object)
                              }
                              return Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          90, 112, 112, 112)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.network(
                                      res!.image.toString(),
                                      //image
                                      // 'https://images.unsplash.com/photo-1543946602-a0fce8117697?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80',
                                      width: MediaQuery.of(context).size.width /
                                          3.7,
                                      fit: BoxFit.fill,
                                    ),
                                    Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      padding: const EdgeInsets.only(
                                          left: 7, top: 11),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        minHeight: 0,
                                                        maxHeight: 50),
                                                margin: const EdgeInsets.only(
                                                    bottom: 1),
                                                // color: Colors.amber,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.2,
                                                child: AutoSizeText(
                                                  //name
                                                  res.name
                                                      // snapshot.data![index].name
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                //weight
                                                res.weight.toString(),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(top: 3),
                                                // width: 70,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
//final prie

                                                      '₹${res.finalprice}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      //actual price

                                                      '₹${res.finalprice}',
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 35),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    itemscount =
                                                        box.values.length;
                                                  });
                                                  setState(() {
                                                    CartModels? data =
                                                        box.get(res.id);
                                                    int quantity = int.parse(
                                                        data!.quantity
                                                            .toString());

                                                    quantity++;
                                                  });
                                                },
                                                child: InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        getFav(int.parse(
                                                            res.id.toString()));
                                                        setState(() {
                                                          if (fav?.id == null) {
                                                            addtoFavHive(
                                                                int.parse(res.id
                                                                    .toString()),
                                                                res.name
                                                                    .toString(),
                                                                res.image
                                                                    .toString());
                                                          } else {
                                                            dltFav(int.parse(res
                                                                .id
                                                                .toString()));
                                                          }
                                                        });
                                                      });
                                                    },
                                                    child: fav?.id != null
                                                        ? const Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Colors.grey,
                                                          )),
                                              )),
                                          SizedBox(
                                            width: 80,
                                            height: 26,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 26,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1)),
                                                  child: IconButton(
                                                    onPressed: () async {


                                                      setState(() {
                                                        itemscount =
                                                            box.values.length;
                                                      });
                                                      setState(() {
                                                        var cartbox =
                                                            AddtoCartBox
                                                                .getCartBox();
                                                        int quantity =
                                                            int.parse(res
                                                                .quantity
                                                                .toString());
                                                        quantity--;
                                                        if (quantity < 1) {
                                                          dltCart(int.parse(res
                                                              .id
                                                              .toString()));
                                                          setState(() {
                                                            itemscount = box
                                                                .values.length;
                                                          });
                                                        } else {
                                                          addtoCArtHive(
                                                              int.parse(res.id
                                                                  .toString()),
                                                              res.name
                                                                  .toString(),
                                                              res.image
                                                                  .toString(),
                                                              quantity,
                                                              res.actualprice
                                                                  .toString(),
                                                              res.finalprice
                                                                  .toString(),
                                                              0.00.toString());
                                                        }
                                                      });
                                                      setState(() {
                                                        for (int i = 0;
                                                            i <=
                                                                box.values
                                                                    .length;
                                                            i++) {
                                                          int price = int.parse(res
                                                                  .actualprice
                                                                  .toString()) *
                                                              int.parse(res
                                                                  .quantity
                                                                  .toString());

                                                          print(i);
                                                          print(price);
                                                          setState(() {
                                                            totol =
                                                                price + totol;
                                                          });
                                                          print(totalPrice);
                                                        }
                                                      });
                                                      setState(() {});
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                        Icons.remove,
                                                        size: 20,
                                                        color: Colors.white),
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                ),
                                                Container(
                                                    height: 26,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.green),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(1)),
                                                    child: Center(
                                                      child: Text(
                                                        res.quantity.toString(),
                                                        // snapshot
                                                        //     .data![index].quantity
                                                        //     .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    )),
                                                Container(
                                                  height: 26,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1)),
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      int quantity = int.parse(
                                                          res.quantity
                                                              .toString());
                                                      quantity++;
                                                      setState(() {
                                                        addtoCArtHive(
                                                            int.parse(res.id
                                                                .toString()),
                                                            res.name.toString(),
                                                            res.image
                                                                .toString(),
                                                            quantity,
                                                            res.actualprice
                                                                .toString(),
                                                            res.finalprice
                                                                .toString(),
                                                            0.00.toString());
                                                      });
                                                      setState(() {
                                                        for (int i = 0;
                                                            i <=
                                                                box.values
                                                                    .length;
                                                            i++) {
                                                          int price = int.parse(res
                                                                  .actualprice
                                                                  .toString()) *
                                                              int.parse(res
                                                                  .quantity
                                                                  .toString());

                                                          print(i);
                                                          print(price);
                                                          setState(() {
                                                            totol =
                                                                price + totol;
                                                          });
                                                          print(totalPrice);
                                                        }
                                                      });

                                                      setState(() {});
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox()
                                        ])
                                  ],
                                ),
                              );
                            })
                        : Text('nothin in dat');
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 15),
                  const Expanded(
                      child: Text(
                    "Recommendation",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Show More',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 155, 55, 1), fontSize: 15),
                      )),
                  const SizedBox(
                    width: 14,
                  )
                ],
              ),
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: const [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Bill Details',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Text(
                            'Product price (${itemscount.toString()} item)',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 35),
                          child: Container(
                            child: Row(
                              children:  [
                                const Icon(
                                    IconData(
                                      0xf04e1,
                                      fontFamily: 'MaterialIcons',
                                    ),
                                    size: 20),
                                Text(
                                  totol.toString(),
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        // SizedBox(
                        //   width: 15,
                        // ),
                        Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: Text(
                            'Delivery charges',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 35),
                            child: Text(
                              'Free',
                              style: TextStyle(fontSize: 18),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    // DottedLine(dashLength: 40),
                    SizedBox(
                      height: 5,
                      width: MediaQuery.of(context).size.width - 35,
                      // color: Colors.amber,
                      child: Column(
                        children: const [
                          DottedLine(
                            dashLength: 10,
                            dashGapLength: 8,
                            dashColor: Colors.black,
                          ),
                          DottedLine(
                            dashLength: 10,
                            dashGapLength: 8,
                            dashColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SizedBox(
                        //   width: 15,
                        // ),
                        const Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: Text(
                            'Total price',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 35),
                          child: Row(
                            children:  [
                             const Icon(
                                  IconData(
                                    0xf04e1,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  size: 20),
                              Text(
                                totol.toString(),
                                style:const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.width,
        // color: Colors.amber,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const  Color.fromRGBO(0, 155, 55, 1)),
                onPressed: () {

                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return Selectaddress(totalprice: totol);
                    // return const ;
                  })));
                },
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: const Center(
                      child: AutoSizeText(
                    'Add to Cart',
                    style: TextStyle(fontSize: 20),
                  )),
                )),
          ],
        ),
      ),
    );
  }
}
