import 'package:ecommerce/pages/bottomnav.dart';
import 'package:ecommerce/pages/home.dart';
import 'package:ecommerce/pages/selectloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Enterloc extends StatefulWidget {
  const Enterloc({super.key});

  @override
  State<Enterloc> createState() => _EnterlocState();
}

class _EnterlocState extends State<Enterloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,

          // color: Colors.amber,
          // height: MediaQuery.of(context).size.height,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width - 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(13)),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamedAndRemoveUntil(context,PageRouteBuilder(pageBuilder: (context,a,b)=>Locselect()), (route) => false)
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, a, b) => Locselect()),
                              (route) => false);
                        },
                        child: const Icon(
                          IconData(
                            0xe793,
                            fontFamily: 'MaterialIcons',
                            matchTextDirection: true,
                          ),
                          size: 30,
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Expanded(
                              child: TextFormField(
                            autofocus: false,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                border: InputBorder.none,
                                hintText: 'Serach location manually'),
                          )))
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset(
                          'assests/images/gpsicn.png',
                          height: 25,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, a, b) => BotmNav()),
                              (route) => false);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: const Text(
                            'Use My Current Location',
                            style: TextStyle(
                                fontSize: 21,
                                color: Color.fromRGBO(0, 155, 55, 1)),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
