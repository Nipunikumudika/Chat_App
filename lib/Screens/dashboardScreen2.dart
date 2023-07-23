// import 'package:chat_app/Screens/selectUsersScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../Controllers/userController.dart';
// import '../Models/user.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   UserController userController = Get.put(UserController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Welcome to Hello Chat")),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (context) => SelectUsersScreen()));
//         },
//         child: const Icon(Icons.person_add),
//       ),
//       body: Column(children: [
//         const Padding(
//           padding: EdgeInsets.only(top: 20, bottom: 20),
//           child: Text(
//             "Dashboard",
//             style: TextStyle(
//               color: Colors.blue,
//               fontSize: 35,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             child: Obx(() => ListView.builder(
//                 itemCount: userController.friendList.value.length,
//                 itemBuilder: (context, index) {
//                   User user = userController.friendList.value[index];
//                   return GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.blue),
//                       height: 30,
//                       margin: EdgeInsets.all(15),
//                       child: Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Text(user.username!),
//                       ),
//                     ),
//                   );
//                 })),
//           ),
//         ),
//       ]),
//     );
//   }
// }
