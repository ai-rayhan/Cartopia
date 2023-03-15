// import '../Provider/Products.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../Provider/product.dart';

// class EditProductScreen extends StatefulWidget {
//   const EditProductScreen({super.key});
//   static const routeName = "edit_product_screen";

//   @override
//   State<EditProductScreen> createState() => _EditProductScreenState();
// }

// class _EditProductScreenState extends State<EditProductScreen> {

//   TextEditingController imageController = TextEditingController();
//   FocusNode imageUrlFocusNode = FocusNode();
//   final _formKey = GlobalKey<FormState>();

//   Product editedProduct = Product(
//     id: '',
//     title: '',
//     price: 0,
//     description: '',
//     imageUrl: '',
//   );

//   @override
//   void dispose() {
//     imageController.dispose();
//     imageUrlFocusNode.dispose();
//     super.dispose();
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   imageUrlFocusNode.addListener(_updateImageUrl);
//   // }

//   void _updateImageUrl() {
//     if (!imageUrlFocusNode.hasFocus) {
//       if ((!imageController.text.startsWith('http') &&
//               !imageController.text.startsWith('https')) ||
//           (!imageController.text.endsWith('.png') &&
//               !imageController.text.endsWith('.jpg') &&
//               !imageController.text.endsWith('.jpeg'))) {
//         return;
//       }
//       setState(() {});
//     }
//   }

// _saveForm() {
//   print(editedProduct.imageUrl);
//   print(editedProduct.description);
//   print(editedProduct.title);
//   Provider.of<Products>(context, listen: false).addProduct(editedProduct);
//   final isValid = _formKey.currentState?.validate();
//   if (!isValid!) {
//     return;
//   }
//   _formKey.currentState?.save();
//   //  Navigator.pop(context);
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Product"),
//         actions: [
//           IconButton(
//             onPressed: _saveForm,
//             icon: const Icon(Icons.save),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Title'),
//                 autocorrect: false,
//                 keyboardType: TextInputType.name,
//                 textInputAction: TextInputAction.next,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please provide a value.';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   editedProduct = Product(
//                     id: editedProduct.id,
//                     title: value!,
//                     description: editedProduct.description,
//                     price: editedProduct.price,
//                     imageUrl: editedProduct.imageUrl,
//                     isFavorite: editedProduct.isFavorite,
//                   );
//                 },

//                 //  onFieldSubmitted: (_) {
//                 //    _saveForm();
//                 //  },
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Price'),
//                 autocorrect: false,
//                 keyboardType: TextInputType.number,
//                 textInputAction: TextInputAction.next,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a price.';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Please enter a valid number.';
//                   }
//                   if (double.parse(value) <= 0) {
//                     return 'Please enter a number greater than zero.';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   editedProduct = Product(
//                     id: editedProduct.id,
//                     title: editedProduct.title,
//                     description: editedProduct.description,
//                     price: double.parse(value!),
//                     imageUrl: editedProduct.imageUrl,
//                     isFavorite: editedProduct.isFavorite,
//                   );
//                 },

//                 //  onFieldSubmitted: (_) {
//                 //    _saveForm();
//                 //  },
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Description'),
//                 autocorrect: false,
//                 maxLines: 4,
//                 keyboardType: TextInputType.multiline,
//                 textInputAction: TextInputAction.next,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a description.';
//                   }
//                   if (value.length < 10) {
//                     return 'Should be at least 10 characters long.';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   editedProduct = Product(
//                     id: editedProduct.id,
//                     title: editedProduct.title,
//                     description: value!,
//                     price: editedProduct.price,
//                     imageUrl: editedProduct.imageUrl,
//                     isFavorite: editedProduct.isFavorite,
//                   );
//                 },

//                 //  onFieldSubmitted: (_) {
//                 //    _saveForm();
//                 //  },
//               ),
//               Row(
//                 children: [
//                   Container(
//                     height: 100,
//                     width: 100,
//                     margin: const EdgeInsets.only(top: 10, right: 8),
//                     decoration: BoxDecoration(border: Border.all(width: 2)),
//                     child: imageController.text.isEmpty
//                         ? const Text('Enter URL')
//                         : FittedBox(
//                             child: Image.network(
//                               imageController.text,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                   ),
//                   Expanded(
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Image URL',
//                       ),
//                       // Can't use initialValue if there is a controller.
//                       //initialValue: _initValues['imageUrl'],
//                       autocorrect: false,
//                       keyboardType: TextInputType.url,
//                       textInputAction: TextInputAction.done,
//                       controller: imageController,
//                       focusNode: imageUrlFocusNode,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter an image URL.';
//                         }
//                         if (!value.startsWith('http') &&
//                             !value.startsWith('https')) {
//                           return 'Please enter a valid URL.';
//                         }
//                         if (!value.endsWith('.png') &&
//                             !value.endsWith('.jpg') &&
//                             !value.endsWith('.jpeg')) {
//                           return 'Please enter a valid image URL.';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         editedProduct = Product(
//                           id: editedProduct.id,
//                           title: editedProduct.title,
//                           description: editedProduct.description,
//                           price: editedProduct.price,
//                           imageUrl: value!,
//                           isFavorite: editedProduct.isFavorite,
//                         );
//                       },
//                       onFieldSubmitted: (_) {
//                         // _saveForm();
//                       },
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/Products.dart';
import '../Provider/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductScreen({super.key});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    // print(_editedProduct.title);
    // print(_editedProduct.description);
    // print(_editedProduct.price);
    // print(_editedProduct.imageUrl);
    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    title: value!,
                    price: _editedProduct.price,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    id: '',
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    title: _editedProduct.title,
                    price: double.parse(value!),
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    id: '',
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _editedProduct = Product(
                    title: _editedProduct.title,
                    price: _editedProduct.price,
                    description: value!,
                    imageUrl: _editedProduct.imageUrl,
                    id: '',
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageUrl: value!,
                          id: '',
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
