// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce/models/homepagemodel.dart' as modelslider;
import 'package:ecommerce/models/postproductdetail.dart' as model;
import 'package:ecommerce/webservices/get.dart';

import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../webservices/postdatatodetailpage.dart';
import '../widgets/itemcard.dart';

class ItemDetailpage extends StatefulWidget {
  // final Categories dataitem;
  final index;
  final id;

  const ItemDetailpage({super.key, required this.index, required this.id});

  @override
  State<ItemDetailpage> createState() => _ItemDetailpageState();
}

class _ItemDetailpageState extends State<ItemDetailpage> {
  var getDetails;
  bool isLoading = true;
  detailspage() async {
    var res = await HttpService.getProductDetails(widget.id);
    setState(() {
      getDetails = model.DetailsModel.fromJson(res);
      isLoading = false;
    });
    return getDetails;
  }

  // ignore: prefer_typing_uninitialized_variables
  var getSlider;
  bool isSliderloading = true;

  sliderData() async {
    var res = await HttpService.getHomePage();
    setState(() {
      getSlider = modelslider.HomePageModel.fromJson(res);
      isSliderloading = false;
      // print('HomePage Data: ' + getSlider.message.toString());
    });
    return getSlider;
  }

  @override
  void initState() {
    super.initState();
    detailspage();

    sliderData();
  }

  Widget build(BuildContext context) {
    IconButton AddtoFav(bool isfav) {
      return IconButton(
          onPressed: () {
            if (isfav != true) {
              setState(() {
                isfav = true;
              });
            } else {
              isfav = false;
            }
          },
          icon: isfav == false
              ? Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.grey,
                  size: 20,
                )
              : const Icon(Icons.favorite, color: Colors.pink, size: 20));
    }

    setState(() {
      postdata(widget.id);
    });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.green,
          ),
          actionsIconTheme: const IconThemeData(
            size: 30,
          ),
          titleSpacing: 0,
          title: const Text(
            'Product Details',
            style: TextStyle(
                color: Colors.black, fontSize: 19, fontWeight: FontWeight.w400),
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_on_outlined)),
            )
          ],
        ),
        body: isLoading == false
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                // controller: controller,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      getDetails.images[0].imgProduct.toString(),
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                // color: Colors.amber,
                                width: MediaQuery.of(context).size.width / 1.9,
                                child: Text(
                                  getDetails.name,
                                  // respons!['deals_array'][widget.index]['name']
                                  //     .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 23),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.grey,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.share,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                          Text(getDetails.description),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' ₹ ${getDetails.finalPrice} ',
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "₹${getDetails.actualPrice}",
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              Text(
                                "40% OFF",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3)
                                ],
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: const [
                              Text(
                                'Varient',
                                style: TextStyle(fontSize: 19),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            height: 50,
                            child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 1,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return GroupButton(
                                    // maxSelected: 2,

                                    options: GroupButtonOptions(
                                        borderRadius: BorderRadius.circular(1),
                                        buttonHeight: 30,
                                        buttonWidth: 50,
                                        unselectedTextStyle: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                        unselectedBorderColor:
                                            // Color.fromRGBO(0, 155, 55, 1),
                                            Colors.grey,
                                        selectedColor:
                                            Color.fromRGBO(0, 155, 55, 1)),
                                    buttons: buttons,
                                    onSelected: ((value, index, isSelected) {}),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Product Details",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "this is product description.this is product description.this is product description.this is product description.this is product description.this is product description.this is product description.",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Similar Products",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(top: 12),
                          //   // margin: const EdgeInsets.only(
                          //   //     top: 10, left: 15, right: 5, bottom: 10),
                          //   height: 230,
                          //   child: ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //       itemCount: 3,
                          //       itemBuilder: ((context, index) {
                          //         return homecard(
                          //             context,
                          //             index,
                          //             getSlider.dealsArray![index].images[0]
                          //                 .imgProduct
                          //                 .toString(),
                          //             getSlider.dealsArray[index].name
                          //                 .toString(),
                          //             getSlider.dealsArray[index].finalPrice
                          //                 .toString(),
                          //             getSlider.dealsArray[index].actualPrice
                          //                 .toString(),
                          //             getSlider.dealsArray[index].id,
                          //             AddtoFav(false));
                          //       })),
                          // ),
                          Container(
                  margin: const EdgeInsets.only(
                      top: 10, left: 15, right: 5, bottom: 10),
                  height: 230,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: getSlider != null
                          ? getSlider.dealsArray.length
                          : 1,
                      itemBuilder: ((context, index) {
                        return getSlider != null
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ItemDetailpage(
                                          index: index,
                                          id: getSlider.dealsArray[index].id),
                                    ),
                                  );
                                },
                                child: homecard(
                                  context,
                                  index,
                                  getSlider
                                      .dealsArray[index].images[0].imgProduct
                                      .toString(),
                                  getSlider.dealsArray[index].name,
                                  getSlider.dealsArray[index].actualPrice
                                      .toString(),
                                  getSlider.dealsArray[index].finalPrice
                                      .toString(),
                                  getSlider.dealsArray[index].id,
                                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined,size: 20,))
                                 , Stack(children: [
                  Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                            color: const Color.fromRGBO(0, 155, 55, 1))),
                  ),
                  const Positioned(
                      top: 3,
                      left: 32,
                      child: Icon(
                        Icons.add,
                        color: Color.fromRGBO(0, 155, 55, 1),
                      ))
                ])
                                ),
                              )
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
                          Container(
                            height: MediaQuery.of(context).size.height / 9,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator())),
        bottomSheet: isLoading == false
            ? Container(
                height: MediaQuery.of(context).size.height / 9.3,
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(0, 155, 55, 1)),
                        onPressed: () {},
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2.8,
                          child: Center(
                              child: AutoSizeText(
                            'Add to Cart',
                            style: TextStyle(fontSize: 20),
                          )),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                color: Color.fromRGBO(0, 155, 55, 1)),
                            backgroundColor:
                                Color.fromARGB(255, 255, 255, 255)),
                        onPressed: () {},
                        child: SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2.8,
                          child: Center(
                              child: AutoSizeText(
                            'Buy Now',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(0, 155, 55, 1)),
                          )),
                        ))
                  ],
                ),
              )
            : null);
  }
}

Widget Customradiobutton(String data, int index) {
  return OutlinedButton(
    onPressed: () {},
    child: Text(data),
  );
}

List buttons = [
  '1 kg',
  '2 kg',
  '3 kg',
  '4 kg',
  '5 kg',
  '6 kg',
  '7 kg',
  '8 kg',
  '9 kg',
  '10 kg',
];
