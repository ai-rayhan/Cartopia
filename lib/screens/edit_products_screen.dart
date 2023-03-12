import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),
      body: Form(child: ListView(
        children: [
          TextField(decoration: InputDecoration(label: Text("Title"),labelText:"Title"),),
        ],
      )),
    );
  }
}
