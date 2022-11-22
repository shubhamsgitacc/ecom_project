import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Sliders extends StatefulWidget {
  const Sliders({super.key});

  @override
  State<Sliders> createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  List prodname = ['Vegetables', 'Fruits', 'Snacks', 'Fish', 'Dairy'];
  List img = [
    'assests/images/vegeicn.png',
    'assests/images/fruitsicn.png',
    'assests/images/snacksicn.png',
    'assests/images/fishicn.png',
    'assests/images/dairyicn.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 2),
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: prodname.length,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromRGBO(0, 155, 55, 0.50),
                    // rgba(0, 155, 55, 0.52)
                  ),
                  child: Center(
                    child: Image.asset(
                      img[index],
                      height: 48,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    prodname[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            );
          })),
    );
  }
}

class Mycpncar extends StatefulWidget {
  const Mycpncar({super.key});

  @override
  State<Mycpncar> createState() => _MycpncarState();
}

class _MycpncarState extends State<Mycpncar> {
  List cpn = [
    'assests/images/cpbanner.png',
    'assests/images/cpbanner.png',
    'assests/images/cpbanner.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(bottom: 50),
        child: CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: ((context, index, realIndex) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 60,
                child: Image.asset(
                  cpn[index],
                ),
              );
            }),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
            )));
  }
}
