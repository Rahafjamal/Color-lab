import 'package:citycafe_app/screens/information.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestore extends StatefulWidget {
  const Firestore({super.key});

  @override
  State<Firestore> createState() => _FirestoreState();
}

class _FirestoreState extends State<Firestore> {
    User? user = FirebaseAuth.instance.currentUser;

  // final Stream<QuerySnapshot> _productsStream =
  //     FirebaseFirestore.instance.collection('user').snapshots();

  // Future userdata(BuildContext context) async {
  //   try {
  //     final user =
  //         await FirebaseFirestore.instance.collection("user").doc().get();
  //     email = user['email'];
  //     isAdmin = user['isAdmin'];
  //   } catch (err) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           err.toString(),
  //         ),
  //       ),
  //     );
  //   }
  // }

  // late Future userData;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   userData = userdata(context);
  // }

 
  List<MaterialColor> listcol = [Colors.red, Colors.green, Colors.blue];

  bool isAdmin = false;
  @override
  Widget build(BuildContext context) {
    if (user!.email!.contains('red')) {
      listcol = [
        Colors.red,Colors.red
      ];
    } else if (user!.email!.startsWith('green')) {
      listcol = [
        Colors.green,Colors.green
      ];
    } else if (user!.email!.startsWith('blue')) {
      listcol = [Colors.blue,Colors.blue];
    } else {
      listcol = [Colors.green,Colors.red,Colors.blue];
    }
    return Scaffold(
      appBar: AppBar(),
    body: Container(
      decoration:
                BoxDecoration(gradient: LinearGradient(colors: listcol)),
      child: Column(
        children: [
          RadioListTile(
            value: false,
            title: const Text("normal user"),
            groupValue: isAdmin,
            onChanged: (value) {
              setState(() {
                isAdmin = value!;
              });
            },
          ),
          RadioListTile(
            value: true,
            title: const Text("Admin"),
            groupValue: isAdmin,
            onChanged: (value) {
              setState(() {
                isAdmin = value!;
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const information();
                    },
                  ));
                });
              },
              child: const Text(' Show information')),
        ],
      ),
    )
    );
  }
}





