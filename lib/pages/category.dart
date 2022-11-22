import 'package:ecommerce/models/homepagemodel.dart' as model;
import 'package:ecommerce/pages/card.dart';
import 'package:ecommerce/pages/cart.dart';
import 'package:ecommerce/pages/home.dart';

import 'package:ecommerce/pages/notification.dart';
import 'package:ecommerce/pages/productcategorybased.dart';
import 'package:ecommerce/pages/detailspage.dart';
import 'package:ecommerce/webservices/get.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var getCategoryres;
  getCategory() async {
    var res = await HttpService.getHomePage();
    setState(() {
      getCategoryres = model.HomePageModel.fromJson(res);
      print(getCategoryres.message);
    });
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Container(
                color: Colors.white,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Categor',
                        style: TextStyle(
                            fontSize: 22, color: Color.fromRGBO(0, 155, 55, 1)),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {
                              print(finalQuantity);
                              print(itesm);
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
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                child: GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 3,
                            childAspectRatio: 2.2 / 3),
                    itemCount: getCategoryres.categoryArray.length,
                    itemBuilder: (context, indext) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Categorypage(
                                id: getCategoryres.categoryArray[indext].id,
                              );
                            }));
                          },
                          // onTap: () {
                          //   Navigator.push(context,
                          //       MaterialPageRoute(builder: (context) {return
                          //     ItemDetailpage(dataitem: cate[indext]);
                          //   }));
                          // },
                          child: card(
                              getCategoryres.categoryArray[indext].imagePath
                                  .toString(),
                              getCategoryres.categoryArray[indext].name));
                    }),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

mixin categories {}

class Categories {
  final String? image;
  final String? name;

  Categories({this.name, this.image});
}

final List<Categories> cate = [
  Categories(
      name: 'Fruits & Vegetables', image: 'assests/images/category/one.png'),
  Categories(
      name: 'dairy, bread &  eggs', image: 'assests/images/category/two.png'),
  Categories(
      name: 'Cookies & buiscuits', image: 'assests/images/category/three.png'),
  Categories(
      name: 'Cold drinks & juice', image: 'assests/images/category/four.png'),
  Categories(name: 'snacks', image: 'assests/images/category/five.png'),
  Categories(
      name: 'Atta, Rice & Dal', image: 'assests/images/category/six.png'),
  Categories(name: 'Tea & Coffee', image: 'assests/images/category/tea.png'),
  Categories(
      name: 'Chicken, Meat & Fish', image: 'assests/images/category/eight.png'),
  Categories(name: 'Personal care', image: 'assests/images/category/nine.png'),
  Categories(name: 'Organic', image: 'assests/images/category/ten.png'),
  Categories(
      name: 'Cleaning Essensial', image: 'assests/images/category/eleven.png'),
  Categories(name: 'Breakfast', image: 'assests/images/category/twelve.png')
];
