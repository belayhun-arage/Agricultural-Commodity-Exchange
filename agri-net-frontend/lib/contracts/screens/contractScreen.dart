// import 'dart:ui';

// import 'package:flutter/rendering.dart';

// import '../../libs.dart';

// class ContractScreen extends StatefulWidget {
//   static const String RouteName = "/buyer/contract";
//   const ContractScreen({Key? key}) : super(key: key);

//   @override
//   State<ContractScreen> createState() => _ContractScreenState();
// }

// class _ContractScreenState extends State<ContractScreen> {
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//             child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [ContractDropDown()],
//         ),
//         Flexible(
//           child: ListView.builder(
//               itemCount: buyerContracts.length,
//               itemBuilder: (context, counter) {
//                 return (selectedIndex == 0)
//                     ? buyerContractCard(buyerContracts[counter])
//                     : sellerContractCard(sellerContracts[counter]);
//               }),
//         ),
//       ],
//     )));
//   }

//   Widget ContractDropDown() {
//     return DropdownButton(
//         value: selectedIndex,
//         items: [
//           DropdownMenuItem(
//             child: Text("As Buyer"),
//             value: 0,
//           ),
//           DropdownMenuItem(
//             child: Text("As Seller"),
//             value: 1,
//           )
//         ],
//         onChanged: (int? newValue) {
//           setState(() {
//             selectedIndex = newValue!;
//           });
//         });
//   }

//   Widget buyerContractCard(Contract contract) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
//       child: Material(
//         elevation: 10,
//         child: Container(
//           width: MediaQuery.of(context).size.width - 30,
//           child: Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height / 4 - 20,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).dividerColor,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20))),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 7.5, 10, 7.5),
//                   child: Image.asset(
//                     "assets/images/logo.jpg",
//                   ),
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height / 6 - 15,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Center(
//                           child: Row(
//                             // mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Product :   ",
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 contract.product.productName,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Quantity :   ",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               contract.quantity.toString() + "KG",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Distance :  ",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               contract.distance.toString() + "KM",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Expiry Date :",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               contract.expiryDate.toString(),
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Seller :         ",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               "Seller's Name",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget sellerContractCard(Contract contract) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
//       child: Material(
//         elevation: 10,
//         child: Container(
//           width: MediaQuery.of(context).size.width - 30,
//           child: Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height / 4 - 20,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).dividerColor,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20))),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 7.5, 10, 7.5),
//                   child: Image.asset(
//                     "assets/images/logo.jpg",
//                   ),
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height / 6 - 15,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Center(
//                           child: Row(
//                             // mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Product :   ",
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 contract.product.productName,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Quantity :   ",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               contract.quantity.toString() + "KG",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Distance :  ",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               contract.distance.toString() + "KM",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Expiry Date :",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               contract.expiryDate.toString(),
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Buyer :         ",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               "Buyer's Name",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
