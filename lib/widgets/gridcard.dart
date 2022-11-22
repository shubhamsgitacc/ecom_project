import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Container GridCard(BuildContext context, images, name, InkWell inkWell) {
  return Container(

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
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Align(
            alignment: Alignment.topRight,
            child:inkWell
          ),
        ),
        Align(
            alignment: Alignment(-.2, -.70),
// alignment: Alignment.topCenter,
            child: Image.network(
              // widget.categories.image.toString(),
              images,
              fit: BoxFit.fill,
              height: 53,
            )),
        Align(
          alignment: Alignment(-.5, .10),
          child: Container(
            // color: Colors.amber,
            width: MediaQuery.of(context).size.width / 3.7,
            constraints: const BoxConstraints(minHeight: 30, maxHeight: 37),
            child: AutoSizeText(
              // favtm[index].name.toString(),
              // widget.categories.name.toString(),
              name.toString(),
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
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ),
        Align(
          alignment: const Alignment(-0.9, .55),
          child: SizedBox(
            width: 80,
            //  color: Colors.amberAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  '₹100',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text(
                  '₹65',
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
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
                borderRadius: BorderRadius.circular(3.79),
                border: Border.all(color: const Color.fromRGBO(0, 155, 55, 1))),
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
}
