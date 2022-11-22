import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce/pages/cart.dart';
import 'package:ecommerce/pages/category.dart';
import 'package:ecommerce/pages/favorite.dart';

import 'package:ecommerce/pages/notification.dart';
import 'package:ecommerce/widgets/itemcard.dart';

import 'package:flutter/material.dart';

import '../models/categorymodels.dart' as categorymodels;
import '../webservices/get.dart';
import '../widgets/gridcard.dart';

class Categorypage extends StatefulWidget {
  // final Categories categories;
  final id;
  const Categorypage({super.key, required this.id});

  @override
  State<Categorypage> createState() => _CategorypageState();
}

class _CategorypageState extends State<Categorypage> {
  var isLoading = false;
  var categorydetails;
  categoryDetails() async {
    var res = await HttpService.getCategoryProduct(widget.id);
    setState(() {
      categorydetails = categorymodels.Categorymodels.fromJson(res);
      isLoading = false;
    });
    print(categorydetails.resultArray.length);
    return categorydetails;
  }

  @override
  void initState() {
    categorydetails;
    super.initState();
    categoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      categoryDetails();
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                // constraints: ,
                color: Colors.white,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Color.fromRGBO(0, 155, 55, 1),
                              size: 25,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'ProductDetail',
                            style: TextStyle(
                                fontSize: 22,
                                color: Color.fromRGBO(0, 155, 55, 1)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Mycart()));
                            },
                            child: Image.asset(
                              'assests/images/carticn.png',
                              height: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyNoti()));
                            },
                            child: Image.asset(
                              'assests/images/bellicn.png',
                              height: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                  child: categorydetails != null
                      ? GridView.builder(
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2 / 3.5,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6),
                          shrinkWrap: true,
                          itemCount:
                              //  categorydetails != null
                              //     ? categorydetails.resultArray.length
                              //     :
                              // favtm.length
                              5,
                          itemBuilder: (BuildContext context, int index) {
                            return
                                // GridCard(context, widget.categories.image,
                                //     widget.categories.name, Icons.favorite_outline);
                                Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.84),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(2, 4),
                                  )
                                ],
                              ),
                              child: Stack(
                                children: [
                                  const Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey,
                                        size: 19,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(-.2, -.70),
// alignment: Alignment.topCenter,
                                    child: Image.network(
                                      categorydetails.resultArray[0]
                                          .products[index].images[0].imgProduct
                                          .toString(),
                                      // widget.categories.image.toString(),
                                      // image,
                                      fit: BoxFit.fill,
                                      height: 53,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(-.5, .10),
                                    child: Container(
                                      // color: Colors.amber,
                                      width: MediaQuery.of(context).size.width /
                                          3.7,
                                      constraints: const BoxConstraints(
                                          minHeight: 30, maxHeight: 37),
                                      child: AutoSizeText(
                                        categorydetails.resultArray[0]
                                            .products[index].name,
                                        // widget.categories.name.toString(),
                                        // name.toString(),
                                        // maxLines: 1,
                                        // 'helosdfasdfsfdadasfdasd',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment(-0.9, .36),
                                    child: Text(
                                      '1kg',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                  ),
                                  Align(
                                    alignment: const Alignment(-0.9, .55),
                                    child: SizedBox(
                                      width: 80,
                                      //  color: Colors.amberAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Text(
                                            '₹100',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            '₹65',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const Alignment(0, .95),
                                    child: Container(
                                      height: 28,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(3.79),
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  0, 155, 55, 1))),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Color.fromRGBO(0, 155, 55, 1),
                                          size: 23,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        )),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
