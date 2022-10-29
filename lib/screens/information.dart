import 'package:citycafe_app/Modal/AddProducts.dart';
import 'package:citycafe_app/Modal/UpdateCart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class information extends StatefulWidget {
  const information({super.key});

  @override
  State<information> createState() => _informationState();
}

class _informationState extends State<information> {
   final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('user').snapshots();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get()
            .then((value) {
          setState(() {
            isAdmin = value.data()!['isAdmin'];
          });
        });
      }
    });
  }

  bool isAdmin = false;
  Future<void> update(id) async {
    if (isAdmin) {
      showDialog(
        context: context,
        builder: (context) => UpdataData(documentID: id),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('you are no admin your can not update'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('login')),
          ],
        ),
      );
    }
  }

  Future<void> delete(id) async {
    if (isAdmin) {
      FirebaseFirestore.instance
          .collection('products')
          .doc(id)
          .delete()
          .then((value) => const Text("deleted"));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('you are no admin your can not update'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('login')),
          ],
        ),
      );
    }
  }

  Color col = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                    child: Container(
                        padding: const EdgeInsets.all(25),
                        child: Text(
                          "Password: ${user!.displayName}",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ))),
                Card(
                    child: Container(
                        padding: const EdgeInsets.all(25),
                        child: Text("Email: ${user!.email}",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)))),
                Card(
                    child: Container(
                        padding: const EdgeInsets.all(25),
                        child: Text("ID: ${user!.uid}",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)))),
                Card(
                    child: Container(
                        padding: const EdgeInsets.all(25),
                        child: Text(
                            "is Admin:${snapshot.data!.docs[2]["isAdmin"]} ",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)))),
              ],
            ),
          );
        },
      ),
    );
  }
}
     
 


// title: Text("${data['password']}\n ${data['username']}"),
//                 subt































// class Firestore extends StatefulWidget {
//   const Firestore({super.key});

//   @override
//   State<Firestore> createState() => _FirestoreState();
// }

// class _FirestoreState extends State<Firestore> {
//   final Stream<QuerySnapshot> _productsStream =
//       FirebaseFirestore.instance.collection('user').snapshots();
//   User? user = FirebaseAuth.instance.currentUser;
// //  // Name, email address, and profile photo URL
// //     var name = user!.displayName;
// //     var email = user!.email;

// //     // Check if user's email is verified

// //     // The user's ID, unique to the Firebase project. Do NOT use this value to
// //     // authenticate with your backend server, if you have one. Use
// //     // User.getIdToken() instead.
// //     var uid = user!.uid;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       if (user == null) {
//         print('User is currently signed out!');
//       } else {
//         FirebaseFirestore.instance
//             .collection('user')
//             .doc(user.uid)
//             .get()
//             .then((value) {
//           setState(() {
//             isAdmin = value.data()!['isAdmin'];
//           });
//         });
//       }
//     });
//   }

//   bool isAdmin = false;
//   Future<void> update(id) async {
//     if (isAdmin) {
//       showDialog(
//         context: context,
//         builder: (context) => UpdataData(documentID: id),
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('you are no admin your can not update'),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('login')),
//           ],
//         ),
//       );
//     }
//   }

//   Future<void> delete(id) async {
//     if (isAdmin) {
//       FirebaseFirestore.instance
//           .collection('products')
//           .doc(id)
//           .delete()
//           .then((value) => const Text("deleted"));
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('you are no admin your can not update'),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('login')),
//           ],
//         ),
//       );
//     }
//   }

//   Color col = Colors.red;
//   @override
//   Widget build(BuildContext context) {
    

//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _productsStream,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Card(
//                     child: Container(
//                         padding: EdgeInsets.all(25),
//                         child: Text(
//                           "Password: ${user!.displayName}",
//                           style: TextStyle(
//                               fontSize: 25, fontWeight: FontWeight.bold),
//                         ))),
//                 Card(
//                     child: Container(
//                         padding: EdgeInsets.all(25),
//                         child: Text("Email: ${user!.email}",
//                             style: TextStyle(
//                                 fontSize: 25, fontWeight: FontWeight.bold)))),
//                 Card(
//                     child: Container(
//                         padding: EdgeInsets.all(25),
//                         child: Text("ID: ${user!.uid}",
//                             style: TextStyle(
//                                 fontSize: 25, fontWeight: FontWeight.bold)))),
//                 Card(
//                     child: Container(
//                         padding: EdgeInsets.all(25),
//                         child: Text(
//                             "is Admin:${snapshot.data!.docs[2]["isAdmin"]} ",
//                             style: TextStyle(
//                                 fontSize: 25, fontWeight: FontWeight.bold)))),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
     
 


// // title: Text("${data['password']}\n ${data['username']}"),
// //                 subtitle: Text(data['isAdmin'].toString()),