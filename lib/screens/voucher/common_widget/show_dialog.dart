// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AlertDialog Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _showAlertDialog(context);
//           },
//           child: Text('Buy Voucher'),
//         ),
//       ),
//     );
//   }

//   void _showAlertDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirmation'),
//           content: Text('Are you sure you want to buy this voucher?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Add your logic for "YES" button here
//                 Navigator.of(context).pop(); // Close the AlertDialog
//               },
//               child: Text('YES'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Add your logic for "NO" button here
//                 Navigator.of(context).pop(); // Close the AlertDialog
//               },
//               child: Text('NO'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
