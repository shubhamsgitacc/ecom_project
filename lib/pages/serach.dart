import 'package:flutter/material.dart';

class MYSerachpage extends StatefulWidget {
  const MYSerachpage({super.key});

  @override
  State<MYSerachpage> createState() => _MYSerachpageState();
}

class _MYSerachpageState extends State<MYSerachpage> {
  TextEditingController Serachcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(1000, 238, 238, 238),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top / 2),
                //Search Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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
                        border: Border.all(
                            color: const Color.fromARGB(90, 112, 112, 112)),
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
                          Container(
                            width: MediaQuery.of(context).size.width / 1.6,
                            child: TextField(
                              controller: Serachcontroller,
                              showCursor: true,
                              autofocus: false,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'search for atta, dal, coke & more',
                                  labelStyle: TextStyle(fontSize: 18),
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      color:
                                          Color.fromARGB(255, 129, 129, 129))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                //serch hisory
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20,
                          bottom: 10,
                          left: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width / 1.1),
                      child: const Text(
                        'Search History',
                        style: TextStyle(
                            color: Color.fromARGB(255, 129, 129, 129),
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  // height: 150,
                  // color: Colors.amber,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                                left: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 1.08,
                                right: 10),
                            child: InkWell(
                                onTap: (() {
                                  //  print(media)
                                }),
                                child: Image.asset(
                                  'assests/images/searchicn.png',
                                  height: 23,
                                  // fit: ,
                                )),
                          ),
                          Text(
                            reversedList[index].search.toString(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 129, 129, 129),
                              fontSize: 17,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width / 1.1),
                      child: const Text(
                        'Trending search',
                        style: TextStyle(
                            color: Color.fromARGB(255, 129, 129, 129),
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  // height: 150,
                  // color: Colors.amber,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: trendingsearch.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15,
                                bottom: 8,
                                left: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 1.08,
                                right: 30),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(210, 204, 203, 203),
                                  borderRadius: BorderRadius.circular(13)),
                              child: InkWell(
                                  onTap: (() {
                                    //  print(media)
                                  }),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      trendingsearch[index].image.toString(),
                                      height: 10,
                                      // fit: BoxFit.cover,
                                      // fit: ,
                                    ),
                                  )),
                            ),
                          ),
                          Text(
                            reversedList[index].search.toString(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 110, 110, 110),
                              fontSize: 17,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class SrchHstr {
  String? search;
  SrchHstr({this.search});
}

class Trendingserach {
  String? image, prodname;
  Trendingserach({this.image, this.prodname});
}

final List<SrchHstr> srchhstr = [
  SrchHstr(search: 'coke'),
  SrchHstr(search: 'tea'),
  SrchHstr(search: 'detergent powder'),
  SrchHstr(search: 'note'),
  SrchHstr(search: 'coke'),
];

final List<Trendingserach> trendingsearch = [
  Trendingserach(image: 'assests/images/prodimg/lays.png', prodname: 'coke'),
  Trendingserach(image: 'assests/images/prodimg/lays.png', prodname: 'coke'),
  Trendingserach(image: 'assests/images/prodimg/lays.png', prodname: 'coke'),
  Trendingserach(image: 'assests/images/prodimg/lays.png', prodname: 'coke'),
  Trendingserach(image: 'assests/images/prodimg/lays.png', prodname: 'coke'),
];
var reversedList = new List.from(srchhstr.reversed);
