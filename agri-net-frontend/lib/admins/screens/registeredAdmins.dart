// import '../../libs.dart';

// class AdminsScreen extends StatefulWidget {
//   static String RouteName = "admins";
//   const AdminsScreen({Key? key}) : super(key: key);

//   @override
//   State<AdminsScreen> createState() => _AdminsScreenState();
// }

// class _AdminsScreenState extends State<AdminsScreen> {
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   SchedulerBinding.instance!.addPostFrameCallback((_) {});
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).canvasColor,
//           elevation: 5,
//           toolbarHeight: MediaQuery.of(context).size.height / 13,
//           leading: IconButton(
//               color: Colors.black,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: BackButton()),
//           title: Text(
//             "Registered Admins",
//             style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//           actions: [
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.of(context)
//                         .pushNamed(RegisterAdminPage.RouteName);
//                   },
//                   icon: Icon(Icons.add),
//                   color: Colors.black,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.of(context)
//                           .pushNamed(RegisterAdminPage.RouteName);
//                     },
//                     child: Text(
//                       "New",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         body: BlocBuilder<AdminsBloc, AdminsState>(builder: (context, state) {
//           if (state is GetAllAdminsState) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (state is AllAdminsRetrievedState) {
//             return Column(
//               children: [
//                 Expanded(
//                   child: userRow(state.adminsList),
//                 ),
//               ],
//             );
//           }
//           if (state is NoAdminFoundState) {
//             return Column(
//               children: [
//                 Text("No User is registered yet!"),
//               ],
//             );
//           }
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }));
//   }

//   Widget userRow(List<Admin> admins) {
//     return Flexible(
//       child: ListView.builder(
//           itemCount: admins.length,
//           itemBuilder: (context, counter) {
//             return Padding(
//               padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
//               child: Material(
//                 elevation: 5,
//                 child: Container(
//                   decoration: BoxDecoration(),
//                   child: Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                           onTap: (() => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => UserProfileScreen(
//                                     requestedUser: admins[counter],
//                                   ),
//                                 ),
//                               )),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               CircleAvatar(
//                                 child: ClipOval(
//                                   child: (admins[counter].imgurl != '')
//                                       ? Image.asset(
//                                           admins[counter].imgurl,
//                                           width: 70,
//                                           height: 70,
//                                           fit: BoxFit.cover,
//                                         )
//                                       : Icon(
//                                           Icons.person,
//                                         ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 7.5,
//                               ),
//                               Text(admins[counter].firstname),
//                               SizedBox(
//                                 width: 7.5,
//                               ),
//                               Text(admins[counter].lastname)
//                             ],
//                           ),
//                         ),
//                         IconButton(onPressed: () {}, icon: Icon(Icons.delete))
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
