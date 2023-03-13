import 'package:flutter/material.dart';

import '../Provider/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName = "edit_product_screen";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  TextEditingController imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode imageUrlFocusNode = FocusNode();
  var editedProduct = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  @override
  void dispose() {
    imageController.dispose();
    imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    imageUrlFocusNode.addListener(_updateImageUrl);
  }

  void _updateImageUrl() {
    if (!imageUrlFocusNode.hasFocus) {
      if ((!imageController.text.startsWith('http') &&
              !imageController.text.startsWith('https')) ||
          (!imageController.text.endsWith('.png') &&
              !imageController.text.endsWith('.jpg') &&
              !imageController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  _saveForm() {
    print(editedProduct.id);
    print(editedProduct.title);
    print(editedProduct.price);
    print(editedProduct.description);
    print(editedProduct.imageUrl);
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }

    _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                autocorrect: false,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,

                onSaved: (value) {
                  editedProduct = Product(
                    id: editedProduct.id,
                    title: value!,
                    description: editedProduct.description,
                    price: editedProduct.price,
                    imageUrl: editedProduct.imageUrl,
                    isFavorite: editedProduct.isFavorite,
                  );
                },

                //  onFieldSubmitted: (_) {
                //    _saveForm();
                //  },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                autocorrect: false,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,

                onSaved: (value) {
                  editedProduct = Product(
                    id: editedProduct.id,
                    title: editedProduct.title,
                    description: editedProduct.description,
                    price: double.parse(value!),
                    imageUrl: editedProduct.imageUrl,
                    isFavorite: editedProduct.isFavorite,
                  );
                },

                //  onFieldSubmitted: (_) {
                //    _saveForm();
                //  },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                autocorrect: false,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,

                onSaved: (value) {
                  editedProduct = Product(
                    id: editedProduct.id,
                    title: editedProduct.title,
                    description: value!,
                    price: editedProduct.price,
                    imageUrl: editedProduct.imageUrl,
                    isFavorite: editedProduct.isFavorite,
                  );
                },

                //  onFieldSubmitted: (_) {
                //    _saveForm();
                //  },
              ),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10, right: 8),
                    decoration: BoxDecoration(border: Border.all(width: 2)),
                    child: imageController.text.isEmpty
                        ? const Text('Enter URL')
                        : FittedBox(
                            child: Image.network(
                              imageController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                      ),
                      // Can't use initialValue if there is a controller.
                      //initialValue: _initValues['imageUrl'],
                      autocorrect: false,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      // controller: _imageUrlController,
                      focusNode: imageUrlFocusNode,
                      onSaved: (value) {
                        editedProduct = Product(
                          id: editedProduct.id,
                          title: editedProduct.title,
                          description: editedProduct.description,
                          price: editedProduct.price,
                          imageUrl: value!,
                          isFavorite: editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "you should provide a value";
                        }
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
