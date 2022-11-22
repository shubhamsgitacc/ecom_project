// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:line_icons/line_icons.dart';

// void main() => runApp(MaterialApp(
//     builder: (context, child) {
//       return Directionality(textDirection: TextDirection.ltr, child: child!);
//     },
//     title: 'GNav',
//     theme: ThemeData(
//       primaryColor: Colors.grey[800],
//     ),
//     home: Example()));

// class Example extends StatefulWidget {
//   @override
//   _ExampleState createState() => _ExampleState();
// }

// class _ExampleState extends State<Example> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Home',
//       style: optionStyle,
//     ),
//     Text(
//       'Likes',
//       style: optionStyle,
//     ),
//     Text(
//       'Search',
//       style: optionStyle,
//     ),
//     Text(
//       'Profile',
//       style: optionStyle,
//     ),
//     Text(
//       'Profile',
//       style: optionStyle,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 20,
//         title: const Text('GoogleNavBar'),
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: Container(
//         // height: 20,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 20,
//               color: Colors.black.withOpacity(.1),
//             )
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//             child: GNav(
//               rippleColor: Colors.grey[300]!,
//               hoverColor: Colors.grey[100]!,
//               gap: 4,
//               activeColor: Colors.black,
//               iconSize: 24,
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//               duration: Duration(milliseconds: 400),
//               tabBackgroundColor: Colors.green,
//               color: Colors.black,
//               tabs: [
//                 GButton(
//                   icon: Icons.home,
//                   text: 'Home',
//                 ),
//                 GButton(
//                   icon: Icons.favorite,
//                   text: 'Likes',
//                 ),
//                 GButton(
//                   icon: Icons.search,
//                   text: 'Search',
//                 ),
//                 GButton(
//                   icon: Icons.category,
//                   text: 'Profile',
//                 ),
//                 GButton(icon: Icons.cabin)
//               ],
//               selectedIndex: _selectedIndex,
//               onTabChange: (index) {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
