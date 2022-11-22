import 'package:ecommerce/pages/serach.dart';
import 'package:flutter/material.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // body: Center(
      //   child: Text('Sup this is search'),
      // ),
      body: MYSerachpage(),
    );
  }
}
