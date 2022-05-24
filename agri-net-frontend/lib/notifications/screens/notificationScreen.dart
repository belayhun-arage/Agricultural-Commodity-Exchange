// import '../../libs.dart';

// class NotificationScreen extends StatefulWidget {
//   static String RouteName = "notifications";
//   const NotificationScreen({Key? key}) : super(key: key);

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).canvasColor,
//         elevation: 5,
//         toolbarHeight: MediaQuery.of(context).size.height / 13,
//         leading: IconButton(
//             color: Colors.black,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: BackButton()),
//         title: Text(
//           "Notifications",
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       ),
//       body: Center(
//         child: Flexible(
//             child: ListView.builder(
//                 itemCount: notifications.length,
//                 itemBuilder: (context, counter) {
//                   return Padding(
//                     padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
//                     child: NotificationCard(notifications[counter]),
//                   );
//                 })),
//       ),
//     );
//   }

//   Widget NotificationCard(ProductNotification pnf) {
//     return Material(
//       elevation: 5,
//       child: Container(
//         width: MediaQuery.of(context).size.width - 20,
//         height: MediaQuery.of(context).size.height / 5 + 50,
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ClipOval(
//                         child: CircleAvatar(
//                           child: ClipOval(
//                             child: Image.asset(
//                               pnf.poster.imgurl,
//                               width: MediaQuery.of(context).size.width / 2,
//                               height: MediaQuery.of(context).size.height * 0.2,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Text(
//                         "Posted Now",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Location : " + pnf.location.toString(),
//                                   style:
//                                       TextStyle(fontWeight: FontWeight.bold)),
//                               Text("Distance : " + pnf.distance.toString(),
//                                   style:
//                                       TextStyle(fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.cancel),
//                     ],
//                   )
//                 ],
//               ),
//               Container(
//                 // height: MediaQuery.of(context).size.height / 5,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                         pnf.poster.firstname +
//                             " Post A New Product You May Like",
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.bold)),
//                     Text(
//                         pnf.poster.firstname +
//                             " is our user who sold products recently",
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Flexible(
//                           child: Image.asset(
//                             pnf.poster.imgurl,
//                             height: MediaQuery.of(context).size.height / 8 - 10,
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               "More",
//                             ),
//                             Icon(Icons.more_horiz_outlined)
//                           ],
//                         )
//                       ],
//                     )
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
