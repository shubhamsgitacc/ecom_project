import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

card(String img, String name) {
  return Container(
    height: 130,
    width: 80,
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(90, 112, 112, 112)),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.84),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 4),
        )
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Image.network(
            img,
            height: 80,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Center(
            child: AutoSizeText(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

// class Myhomecare extends StatelessWidget {
//   const Myhomecare({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//                       constraints: const BoxConstraints(minHeight: 0, maxHeight: 20.0),
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                         height: 210,
//                         width: 130,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                                 color: const Color.fromARGB(90, 112, 112, 112)),
//                             borderRadius: BorderRadius.circular(8.84),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.3),
//                                 spreadRadius: 2,
//                                 blurRadius: 2,
//                                 offset: const Offset(0, 0),
//                               )
//                             ]),
//                         child: InkWell(
//                           onTap: () {
//                             // Navigator.push(context,
//                             //     MaterialPageRoute(builder: ((context) {
//                             //   return ItemDetailpage(favitem: fav[index]);
//                             // }))
//                             // );
//                           },
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 // right:0,
//                                 left: 90,
//                                 // top: 1,
//                                 bottom: 180,
//                                 child: IconButton(
//                                   onPressed: () {
                                    



 
 
                                    
//                                   },
//                                   icon: Icon(
//                                     Icons.favorite_border_rounded,
//                                     color: _color,
//                                     size: 20,
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                   top: 35,
//                                   left: 20,
//                                   child: Image.asset(
//                                     fav[index].image.toString(),
//                                     height: 60,
//                                     width: 80,
//                                   )),
//                               Positioned(
//                                 top: 110,
//                                 left: 10,
//                                 child: Text(
//                                   fav[index].name.toString(),
//                                   style: const TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               const Positioned(
//                                 top: 135,
//                                 left: 10,
//                                 child: Text(
//                                   '1kg',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.grey),
//                                 ),
//                               ),
//                               Positioned(
//                                   top: 156,
//                                   child: Container(
//                                     width: 100,
//                                     // color: Colors.amber,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: const [
//                                         Text(
//                                           '₹100',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 18),
//                                         ),
//                                         Text(
//                                           '₹65',
//                                           style: TextStyle(
//                                               decoration:
//                                                   TextDecoration.lineThrough,
//                                               fontSize: 15,
//                                               color: Colors.grey),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                               Positioned(
//                                   bottom: 5,
//                                   left: 19,
//                                   child: Container(
//                                       child: Stack(children: [
//                                     Container(
//                                       height: 30,
//                                       width: 90,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(3),
//                                           border: Border.all(
//                                               color: const Color.fromRGBO(
//                                                   0, 155, 55, 1))),
//                                     ),
//                                     const Positioned(
//                                         top: 3,
//                                         left: 32,
//                                         child: Icon(
//                                           Icons.add,
//                                           color: Color.fromRGBO(0, 155, 55, 1),
//                                         ))
//                                   ])))
//                             ],
//                           ),
//                         ));
//                   }
            
//   }


// homecard(){
//   return Container(
//                       constraints: const BoxConstraints(minHeight: 0, maxHeight: 20.0),
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                         height: 210,
//                         width: 130,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                                 color: const Color.fromARGB(90, 112, 112, 112)),
//                             borderRadius: BorderRadius.circular(8.84),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.3),
//                                 spreadRadius: 2,
//                                 blurRadius: 2,
//                                 offset: const Offset(0, 0),
//                               )
//                             ]),
//                         child: InkWell(
//                           onTap: () {
//                             // Navigator.push(context,
//                             //     MaterialPageRoute(builder: ((context) {
//                             //   return ItemDetailpage(favitem: fav[index]);
//                             // })));
//                           },
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 // right:0,
//                                 left: 90,
//                                 // top: 1,
//                                 bottom: 180,
//                                 child: IconButton(
//                                   onPressed: () {
//                                     setState(() {});
//                                   },
//                                   icon: Icon(
//                                     Icons.favorite_border_rounded,
//                                     color: _color,
//                                     size: 20,
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                   top: 35,
//                                   left: 20,
//                                   child: Image.asset(
//                                     fav[index].image.toString(),
//                                     height: 60,
//                                     width: 80,
//                                   )),
//                               Positioned(
//                                 top: 110,
//                                 left: 10,
//                                 child: Text(
//                                   fav[index].name.toString(),
//                                   style: const TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               const Positioned(
//                                 top: 135,
//                                 left: 10,
//                                 child: Text(
//                                   '1kg',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.grey),
//                                 ),
//                               ),
//                               Positioned(
//                                   top: 156,
//                                   child: Container(
//                                     width: 100,
//                                     // color: Colors.amber,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: const [
//                                         Text(
//                                           '₹100',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 18),
//                                         ),
//                                         Text(
//                                           '₹65',
//                                           style: TextStyle(
//                                               decoration:
//                                                   TextDecoration.lineThrough,
//                                               fontSize: 15,
//                                               color: Colors.grey),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                               Positioned(
//                                   bottom: 5,
//                                   left: 19,
//                                   child: Container(
//                                       child: Stack(children: [
//                                     Container(
//                                       height: 30,
//                                       width: 90,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(3),
//                                           border: Border.all(
//                                               color: const Color.fromRGBO(
//                                                   0, 155, 55, 1))),
//                                     ),
//                                     const Positioned(
//                                         top: 3,
//                                         left: 32,
//                                         child: Icon(
//                                           Icons.add,
//                                           color: Color.fromRGBO(0, 155, 55, 1),
//                                         ))
//                                   ])))
//                             ],
//                           ),
//                         ));
//                   }
            
