import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce/hive/hiveaddtocart.dart';
import 'package:ecommerce/hive/hivefav.dart';
import 'package:ecommerce/local%20storage/addtocar.dart';
import 'package:ecommerce/local%20storage/addtofav.dart';
import 'package:ecommerce/models/addtocartmodel.dart';
import 'package:ecommerce/models/favmodel.dart';
import 'package:ecommerce/models/homepagemodel.dart' as model;
import 'package:ecommerce/pages/cart.dart';
import 'package:ecommerce/pages/category.dart';
import 'package:ecommerce/pages/favorite.dart';
import 'package:ecommerce/pages/notification.dart';
import 'package:ecommerce/pages/detailspage.dart';
import 'package:ecommerce/pages/productcategorybased.dart';
import 'package:ecommerce/pages/profile.dart';
import 'package:ecommerce/pages/search.dart';
import 'package:ecommerce/pages/serach.dart';
import 'package:ecommerce/provider/favprovider.dart';
import 'package:ecommerce/webservices/get.dart';
import 'package:ecommerce/widgets/itemcard.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:objectbox/objectbox.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';

List addtoCart = [];
List quantitys = [0, 0, 0, 0, 0];
List finalQuantity = [];
List itesm = [];

Future dltFav(int id) async {
  final favbox = FavBox.getFavBox();
  favbox.delete(id);
}

Future dltCart(int id) async {
  final cartbox = AddtoCartBox.getCartBox();
  cartbox.delete(id);
}

Future getCart(int id) async {
  final cartbox = AddtoCartBox.getCartBox();
  cart = cartbox.get(id);

  return cart;
}

Future addtoCArtHive(int id, String name, String image, int quantity,
    String actualPrice, String finalPrice, String weight) async {
  final cartmodel = CartModels(
      id: id,
      name: name,
      image: image,
      actualprice: actualPrice,
      finalprice: finalPrice,
      quantity: quantity,
      weight: weight);
  final cartbox = AddtoCartBox.getCartBox();
  cartbox.put(id, cartmodel);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List fasv = [];
List<Map<String, dynamic>>? cartdatalists;
FavModels? fav;
CartModels? cart;
Future addtoFavHive(int id, String name, String image) async {
  final favmodels = FavModels(id: id, name: name, image: image);

  final favBox = FavBox.getFavBox();
  favBox.put(id, favmodels);
}

Color _color = const Color.fromARGB(255, 161, 161, 161);
Color _favcolr = Colors.pinkAccent;
var add = 'Shop no.2, Crysal shopping arcade';

class _HomeState extends State<Home> {
  bool isaddedtocart = false;
  // ObjectBox? objectBox;
  bool isLoading = false;
  var getproducts;
  bool isfav = false;
//trupesh
  Stream<List<FavModels>>? favmodellist;
  DbFAVHandlder? dbFAVHandlder;
  DbCartHandler? dbCartHandler;
  CartModels? cartModels;
  int qnty = 1;

  Future getFav(int id) async {
    final favbox = FavBox.getFavBox();

    fav = favbox.get(id);

    return fav;
  }

  homepage() async {
    var res = await HttpService.getHomePage();
    setState(() {
      getproducts = model.HomePageModel.fromJson(res);
      isLoading = false;
      print('HomePage Data: ' + getproducts.message.toString());
    });
    return getproducts;
  }

  late Future<List<FavModels>> favmodelslist;
  int? selectedindex;
  // return categorydetails;

  List favitemindex = [];

  @override
  void initState() {
    super.initState();
    homepage();

    dbCartHandler = DbCartHandler();
    dbFAVHandlder = DbFAVHandlder();
  }

  @override
  void dispose() {
    // Hive.box('AddtoFav').close();
    // Hive.box('AddtoCart').close();
    super.dispose();
  }

  loadCartData() async {
    cartmodelsllist = dbCartHandler!.geCartList();
  }

  @override
  Widget build(BuildContext context) {
    List navpange = [Home(), Category(), Searchpage(), Favorite(), Profile()];
   var favbox = FavBox.getFavBox();
   var carbox = AddtoCartBox.getCartBox();

    List cpn = [
      'assests/images/cpbanner.png',
      'assests/images/cpbanner.png',
      'assests/images/cpbanner.png'
    ];

    return Scaffold(
      //appbar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mumbai, Maharashtra',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Text(
              add.length > 30 ? '${add.substring(0, 30)}...' : add,
              style: const TextStyle(
                  fontSize: 14, color: Color.fromARGB(255, 122, 119, 119)),
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const Mycart())));
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                'assests/images/carticn.png',
              ),
            ),
          ),
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
        leading: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15, right: 0),
          child: Image.asset('assests/images/loc.png'),
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            //Search Bar
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => MYSerachpage())));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                height: 50,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 4),
                    )
                  ],
                  border: Border.all(color: Color.fromARGB(90, 112, 112, 112)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(
                        'assests/images/searchicn.png',
                        height: 25,
                      ),
                    ),
                    InkWell(
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const MYSerachpage())));
                      }),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.6,
                          child: const Text(
                            'Search Product',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )),
                    )
                  ],
                ),
              ),
            ),

            //category
            Container(
              constraints: const BoxConstraints(minHeight: 0, maxHeight: 200),
              margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
              height: 130,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getproducts != null
                      ? getproducts.categoryArray.length
                      : 5,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        print(getproducts.categoryArray[index].id);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Categorypage(
                            id: getproducts.categoryArray[index].id,
                          );
                        }));
                      },
                      child: Column(
                        children: [
                          InkWell(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                // color: const Color.fromRGBO(0, 155, 55, 0.50),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: getproducts != null
                                    ? Image.network(
                                        getproducts
                                            .categoryArray[index].imagePath
                                            .toString(),
                                        height: 40,
                                        fit: BoxFit.fill,
                                      )
                                    : const SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircularProgressIndicator(),
                                      ),
                              ),
                            ),
                          ),
                          Container(
                              height: 50,
                              constraints: const BoxConstraints(
                                  minHeight: 0, maxHeight: 100, maxWidth: 80),
                              margin: const EdgeInsets.only(top: 5),
                              child: getproducts != null
                                  ? AutoSizeText(
                                      getproducts.categoryArray[index].name,
                                      style: const TextStyle(fontSize: 15),
                                    )
                                  : null)
                        ],
                      ),
                    );
                  })),
            ),
            //carousel
            CarouselSlider.builder(
                itemCount: 3,
                itemBuilder: ((context, index, realIndex) {
                  return getproducts != null
                      ? Image.network(
                          getproducts.sliderArray[index].imagePath.toString(),
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        )
                      : const Center(
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator()),
                        );
                }),
                options: CarouselOptions(
                  height: 130,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  enlargeCenterPage: true,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: (3 / 100) * MediaQuery.of(context).size.width),
                  child: const Text(
                    'Top Selling Itmes',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        right: (3 / 100) * MediaQuery.of(context).size.width),
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Show more',
                          style:
                              TextStyle(color: Color.fromRGBO(0, 155, 55, 1)),
                        )))
              ],
            ),
            //listview #one
            Container(
                margin: const EdgeInsets.only(
                    top: 10, left: 15, right: 5, bottom: 10),
                height: 230,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        getproducts != null ? getproducts.dealsArray.length : 5,
                    itemBuilder: ((context, index) {
                      if (getproducts != null) {
                        getFav(int.parse(getproducts.dealsArray[index].id));

                        getCart(int.parse(getproducts.dealsArray[index].id));
                      }
                      // }
                      return getproducts != null
                          ? homecard(
                              context,
                              index,
                              getproducts.dealsArray[index].images[0].imgProduct
                                  .toString(),
                              getproducts.dealsArray[index].name,
                              getproducts.dealsArray[index].actualPrice
                                  .toString(),
                              getproducts.dealsArray[index].finalPrice
                                  .toString(),
                              getproducts.dealsArray[index].id,
                              IconButton(
                                  onPressed: () async {
                                    await IsFAVreal(index);
                                  },
                                  icon: Icon(
                                      fav?.id == null
                                          ? Icons.favorite_border_outlined
                                          : Icons.favorite,
                                      size: 20,
                                      color:
                                          fav?.id != null ? _favcolr : _color)),
                              Stack(children: [
                                cart?.id == null
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            addtoCArtHive(
                                                int.parse(getproducts
                                                    .dealsArray[index].id),
                                                getproducts
                                                    .dealsArray[index].name,
                                                getproducts.dealsArray[index]
                                                    .images[0].imgProduct,
                                                3,
                                                getproducts.dealsArray[index]
                                                    .actualPrice,
                                                getproducts.dealsArray[index]
                                                    .finalPrice,
                                                getproducts.dealsArray[index]
                                                    .actualPrice);
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      0, 155, 55, 1))),
                                          child: const Center(
                                            child: Icon(Icons.add,
                                                color: Color.fromRGBO(
                                                    0, 155, 55, 1)),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 90,
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 26,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(1)),
                                              child: IconButton(
                                                onPressed: () async {
                                                  await Qntyminus(index);
                                                  setState(() {});
                                                },
                                                icon: const Icon(Icons.remove,
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
                                                        color: Colors.green),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1)),
                                                child: Center(
                                                  child: Text(
                                                    cart!.quantity.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                )),
                                            Container(
                                              height: 26,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(1)),
                                              child: IconButton(
                                                onPressed: () async {
                                                  Qntyplus(index);
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

                                //  cart?.id!=null?
                                //   const

                                //   Positioned(
                                //       top: 3,
                                //       left: 32,
                                //       child: Icon(
                                //         Icons.add,
                                //         color: Color.fromRGBO(0, 155, 55, 1),
                                //       ))
                                //       : Container()
                              ]))
                          : const SizedBox(
                              height: 200,
                              width: 160,
                              child: Center(
                                child: SizedBox(
                                    height: 60,
                                    width: 50,
                                    child: CircularProgressIndicator()),
                              ),
                            );
                    }))),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // color: Colors.amber,
                    width: 250,
                    padding: EdgeInsets.only(
                        left: (3 / 100) * MediaQuery.of(context).size.width),
                    child: const Text(
                      'Biscuits, Snaks and chocolates',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          right: (3 / 100) * MediaQuery.of(context).size.width),
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Show more',
                            style:
                                TextStyle(color: Color.fromRGBO(0, 155, 55, 1)),
                          ))),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    top: 10, left: 15, right: 5, bottom: 10),
                height: 230,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        getproducts != null ? getproducts.dealsArray.length : 5,
                    itemBuilder: ((context, index) {
                      // int isfavindx = getproducts.dealsArray[index].id;
                      return getproducts != null
                          ? homecard(
                              context,
                              index,
                              getproducts.dealsArray[index].images[0].imgProduct
                                  .toString(),
                              getproducts.dealsArray[index].name,
                              getproducts.dealsArray[index].actualPrice
                                  .toString(),
                              getproducts.dealsArray[index].finalPrice
                                  .toString(),
                              getproducts.dealsArray[index].id,
                              IconButton(
                                  onPressed: () async {
//inset to fav
                                    addtoFavHive(
                                        int.parse(
                                            getproducts.dealsArray[index].id),
                                        getproducts.dealsArray[index].name,
                                        getproducts.dealsArray[index].images[0]
                                            .imgProduct);
                                    dbFAVHandlder!
                                        .insertFAV(FavModels(
                                      id: int.parse(
                                          getproducts.dealsArray[index].id),
                                      name: getproducts.dealsArray[index].name,
                                      image: getproducts.dealsArray[index]
                                          .images[0].imgProduct,
                                    ))
                                        .then((value) {
                                      setState(() {
                                        favmodelslist =
                                            dbFAVHandlder!.getFavList();
                                      });
                                      print(
                                          'data add' + value.image.toString());
                                    }).onError((error, stackTrace) {
                                      print(error);
                                    });
                                    // getFav(int.parse(getproducts
                                    //     .dealsArray[index].id
                                    //     .toString()));
                                    // print(fav?.name);
                                    // print(fav!.image);
                                    getFav(1);
                                    if (fav?.id == null) {
                                      print('is null');
                                    }

                                    setState(() {
                                      if (favitemindex.contains(getproducts
                                          .dealsArray[index].id
                                          .toString())) {
                                        favitemindex.remove(getproducts
                                            .dealsArray[index].id
                                            .toString());
                                      } else {
                                        favitemindex.add(getproducts
                                            .dealsArray[index].id
                                            .toString());
                                      }
                                      print(getproducts.dealsArray[index].id
                                          .toString());
                                    });
                                  },
                                  icon: Icon(
                                    !favitemindex.contains(getproducts
                                            .dealsArray[index].id
                                            .toString())
                                        ? Icons.favorite_border_outlined
                                        : Icons.favorite,
                                    size: 20,
                                    color: !favitemindex.contains(getproducts
                                            .dealsArray[index].id
                                            .toString())
                                        ? _color
                                        : _favcolr,
                                  )),
                              Stack(children: [
                                GestureDetector(
                                    onTap: () {
                                      dbCartHandler!
                                          .insertCart(
                                        CartModels(
                                            id: int.parse(getproducts
                                                .dealsArray[index].id),
                                            name: getproducts
                                                .dealsArray[index].name,
                                            image: getproducts.dealsArray[index]
                                                .images[0].imgProduct,
                                            actualprice: getproducts
                                                .dealsArray[index].finalPrice,
                                            finalprice: getproducts
                                                .dealsArray[index].finalPrice,
                                            weight: getproducts
                                                .dealsArray[index].actualPrice,
                                            quantity: 1),
                                      )
                                          .then((value) {
                                        print('data add' + value.id.toString());
                                      }).onError((error, stackTrace) {
                                        print(error);
                                      });

                                      ///adding items id in list
                                      ///
                                      setState(() {
                                        if (!itesm.contains(
                                            getproducts.dealsArray[index].id)) {
                                          itesm.add(
                                              getproducts.dealsArray[index].id);
                                          if (itesm.length !=
                                              finalQuantity.length) {
                                            finalQuantity.insert(
                                                itesm.indexOf(getproducts
                                                    .dealsArray[index].id),
                                                1);
                                          }
                                        } else {
                                          null;
                                        }

                                        print(itesm);
                                        print(itesm.indexOf(
                                            getproducts.dealsArray[index].id));

                                        quantitys[itesm.indexOf(getproducts
                                            .dealsArray[index].id)] = 1;

                                        print(finalQuantity);
                                        print(quantitys);
                                        addtoCart.add(
                                            getproducts.dealsArray[index].id);
                                        isaddedtocart = true;
                                      });

                                      ///
                                    },
                                    child: !addtoCart.contains(
                                            getproducts.dealsArray[index].id)
                                        ? Container(
                                            height: 30,
                                            width: 90,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        0, 155, 55, 1))),
                                            child: const Center(
                                                child: Icon(Icons.add,
                                                    color: Color.fromRGBO(
                                                        0, 155, 55, 1))),
                                          )
                                        : InkWell(
                                            onTap: () async {},
                                            child: Container(
                                              width: 90,
                                              height: 30,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 26,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(1)),
                                                    child: IconButton(
                                                      onPressed: () async {
                                                        setState(() {
                                                          int _finalq = finalQuantity[
                                                              itesm.indexOf(
                                                                  getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .id)];
                                                          _finalq--;
                                                          finalQuantity[itesm
                                                              .indexOf(getproducts
                                                                  .dealsArray[
                                                                      index]
                                                                  .id)] = _finalq;
                                                          print(_finalq);
                                                          print(finalQuantity);
                                                          int _finalQuntity =
                                                              finalQuantity[itesm
                                                                  .indexOf(getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .id)];

                                                          if (_finalQuntity <
                                                              1) {
                                                            print(
                                                                'less than one');
                                                            setState(() {
                                                              finalQuantity.removeAt(
                                                                  itesm.indexOf(
                                                                      getproducts
                                                                          .dealsArray[
                                                                              index]
                                                                          .id));
                                                              print(
                                                                  finalQuantity);
                                                              itesm.remove(
                                                                  getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .id);
                                                              print(itesm);

                                                              addtoCart.remove(
                                                                  getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .id);
                                                              dbCartHandler!.deleteFroCart(
                                                                  int.parse(getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .id));
                                                            });
                                                          } else {
                                                            quantitys[itesm.indexOf(
                                                                    getproducts
                                                                        .dealsArray[
                                                                            index]
                                                                        .id)] =
                                                                _finalQuntity;
                                                            dbCartHandler!
                                                                .updateQuantity(
                                                              CartModels(
                                                                  id: int.parse(
                                                                      getproducts
                                                                          .dealsArray[
                                                                              index]
                                                                          .id),
                                                                  name: getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .name,
                                                                  image: getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .images[0]
                                                                      .imgProduct,
                                                                  actualprice: getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .finalPrice,
                                                                  finalprice: getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .finalPrice,
                                                                  weight: getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .actualPrice,
                                                                  quantity:
                                                                      _finalQuntity),
                                                            )
                                                                .then((value) {
                                                              print('data add' +
                                                                  value
                                                                      .toString());
                                                            }).onError((error,
                                                                    stackTrace) {
                                                              print(error);
                                                            });

                                                            print(quantitys);
                                                          }
                                                        });
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
                                                          finalQuantity[itesm.indexOf(
                                                                  getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .id)]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                      )),
                                                  Container(
                                                    height: 26,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(1)),
                                                    child: IconButton(
                                                      onPressed: () async {
                                                        setState(() {
                                                          int _finalQuantity =
                                                              finalQuantity[itesm
                                                                  .indexOf(getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .id)];
                                                          _finalQuantity++;
                                                          finalQuantity[itesm.indexOf(
                                                                  getproducts
                                                                      .dealsArray[
                                                                          index]
                                                                      .id)] =
                                                              _finalQuantity;
                                                          print(_finalQuantity);

                                                          dbCartHandler!
                                                              .updateQuantity(
                                                            CartModels(
                                                                id: int.parse(
                                                                    getproducts
                                                                        .dealsArray[
                                                                            index]
                                                                        .id),
                                                                name: getproducts
                                                                    .dealsArray[
                                                                        index]
                                                                    .name,
                                                                image: getproducts
                                                                    .dealsArray[
                                                                        index]
                                                                    .images[0]
                                                                    .imgProduct,
                                                                actualprice: getproducts
                                                                    .dealsArray[
                                                                        index]
                                                                    .finalPrice,
                                                                finalprice: getproducts
                                                                    .dealsArray[
                                                                        index]
                                                                    .finalPrice,
                                                                weight: getproducts
                                                                    .dealsArray[
                                                                        index]
                                                                    .actualPrice,
                                                                quantity:
                                                                    _finalQuantity),
                                                          )
                                                              .then((value) {
                                                            print('data add' +
                                                                value
                                                                    .toString());
                                                          }).onError((error,
                                                                  stackTrace) {
                                                            print(error);
                                                          });
                                                        });
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
                                          )),
                              ]))
                          : const SizedBox(
                              height: 200,
                              width: 160,
                              child: Center(
                                child: SizedBox(
                                    height: 60,
                                    width: 50,
                                    child: CircularProgressIndicator()),
                              ),
                            );
                    }))),
          ])),
    );
  }

  Future<void> Qntyplus(int index) async {
    await getCart(int.parse(getproducts.dealsArray[index].id));
    print(cart?.quantity);

    int quantity = int.parse(cart!.quantity.toString());
    quantity++;
    await addtoCArtHive(
        int.parse(cart!.id.toString()),
        cart!.name.toString(),
        cart!.image.toString(),
        quantity,
        cart!.actualprice.toString(),
        cart!.finalprice.toString(),
        1.toString());
    print(quantity);
  }

  Future<void> Qntyminus(int index) async {
    await getCart(int.parse(getproducts.dealsArray[index].id));
    print(cart?.quantity);

    int quantity = int.parse(cart!.quantity.toString());
    quantity--;
    if (quantity < 1) {
      dltCart(int.parse(getproducts.dealsArray[index].id));
    } else {
      await addtoCArtHive(
          int.parse(cart!.id.toString()),
          cart!.name.toString(),
          cart!.image.toString(),
          quantity,
          cart!.actualprice.toString(),
          cart!.finalprice.toString(),
          1.toString());
    }
    print(quantity);
  }

  Future<void> IsFAVreal(int index) async {
    await getFav(int.parse(getproducts.dealsArray[index].id));
    if (fav?.id == null) {
      print(' null');
      addtoFavHive(
          int.parse(getproducts.dealsArray[index].id),
          getproducts.dealsArray[index].name,
          getproducts.dealsArray[index].images[0].imgProduct.toString());
    }
    if (fav?.id != null) {
      dltFav(int.parse(getproducts.dealsArray[index].id));
    }
    setState(() {});
    setState(() {
      if (favitemindex.contains([index].toString())) {
        favitemindex.remove([index].toString());
      } else {
        favitemindex.add([index].toString());
      }
      // print(favitemindex.length);
    });
  }
}
