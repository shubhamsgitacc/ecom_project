import 'package:ecommerce/pages/MyOrders.dart';
import 'package:ecommerce/pages/Myaddress.dart';

import 'package:ecommerce/pages/offer.dart';
import 'package:ecommerce/pages/userdetail.dart';
import 'package:ecommerce/webservices/get.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(size: 10),
        title: const Text("Profile", style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              
            },
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
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assests/images/smile.jpg'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Abhishek Jaiswal',
                  style: TextStyle(fontSize: 23),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text('+91 7854779368',
                    style: TextStyle(
                      fontSize: 18,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    SizedBox(width: 10),
                    Text(
                      'My Information',
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    SizedBox()
                  ],
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: lstdtl.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                return classes[index];
                              })));
                            }),
                            child: Container(
                              height: 60,
                              color: Colors.white,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Image.asset(
                                    lstdtl[index].img.toString(),
                                    height: 25,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    lstdtl[index].name.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  const Spacer(),
                                  //  const Icon(Icons.arrow_forward_ios,size: 20,),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'other',
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    SizedBox()
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: lstbtm.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 60,
                            color: Colors.white,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                Image.asset(
                                  lstbtm[index].img.toString(),
                                  height: 25,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  lstbtm[index].name.toString(),
                                  style: const TextStyle(fontSize: 17),
                                ),
                                const Spacer(),
                                // const Icon(Icons.arrow_forward_ios,size: 20,),
                                const SizedBox(
                                  width: 12,
                                ),
                              ],
                            ),
                          );
                        })),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      Image.asset(
                        'assests/images/logouticn.png',
                        height: 25,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'LogOut',
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Listdtl {
  String? name, img;
  Listdtl({this.img, this.name});
}

List<Listdtl> lstdtl = [
  Listdtl(name: 'Personal information', img: 'assests/images/prfi.png'),
  Listdtl(name: 'My Address', img: 'assests/images/prfh.png'),
  Listdtl(name: 'My Orders', img: 'assests/images/prfcart.png'),
  Listdtl(name: 'Promo Codes', img: 'assests/images/prfcpn.png'),
];
List<Listdtl> lstbtm = [
  Listdtl(name: 'Customer Support', img: 'assests/images/prfcsmtsprt.png'),
  Listdtl(name: 'Contact Us', img: 'assests/images/prfexcla.png'),
];
List classes = [
  const UserDetails(),
  MyAddress(),
 MyOrders(),
  MYOfferPage(),
  Profile(),
  Profile(),
];
List Dropdownlist = [const UserDetails()];
