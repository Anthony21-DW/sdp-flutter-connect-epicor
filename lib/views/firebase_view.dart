import 'package:flutter/material.dart';

class FirebaseView extends StatelessWidget {
  const FirebaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[900],
          title: Text(
            "Crud Firebase",
            style: TextStyle(color: Colors.grey[200]),
          )),
      body: Center(child: Text("Halaman List data dari firebase")),
    );
  }
}
