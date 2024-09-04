import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farmerapp/helper/image_picker_factory.dart';
import 'package:farmerapp/helper/image_picker_interface.dart';

class AddProducts extends StatefulWidget {
  final String token;
  const AddProducts({required this.token, super.key});

  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _category;
  Uint8List? _imageBytes;

  final List<String> _categories = [
    'Staple Farm',
    'Dairy Farm',
    'Organic Farm',
    'Poultry Farm',
    'Flower Farm'
  ];

  late final ImagePickerInterface imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = createImagePicker();
    _initializeFarmerId();
  }

  Future<void> _initializeFarmerId() async {
    try {
      Map<String, dynamic> payload = JwtDecoder.decode(widget.token);
      String farmerId = payload['farmerId'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('farmerId', farmerId);
    } catch (e) {
      print('Failed to store farmer ID: $e');
    }
  }

  Future<String?> _getFarmId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? farmerId = prefs.getString('farmerId');

      if (farmerId == null) {
        throw Exception('Farmer ID not found');
      }

      final response = await http.get(
        Uri.parse('http://192.168.29.99:7777/farm/check-farm'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['farmExists']) {
          return data['farmId'];
        } else {
          return null;
        }
      } else {
        throw Exception('Failed to fetch farmId');
      }
    } catch (e) {
      print('Failed to get farm ID: $e');
      return null;
    }
  }

  Future<void> _submitProduct() async {
    final farmId = await _getFarmId();

    if (farmId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Farm ID not found')));
      return;
    }

    if (_formKey.currentState!.validate()) {
      try {
        var request = http.MultipartRequest('POST',
            Uri.parse('http://192.168.29.99:7777/product/add-product/$farmId'));

        request.fields['productName'] = _productNameController.text;
        request.fields['price'] = _priceController.text;
        request.fields['category'] = _category!;
        request.fields['description'] = _descriptionController.text;

        if (_imageBytes != null) {
          request.files.add(http.MultipartFile.fromBytes('image', _imageBytes!,
              filename: 'image.jpg'));
        }

        var response = await request.send();

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product added successfully')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Failed to add product ${response.statusCode}')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _pickImage() async {
    final imageBytes = await imagePicker.pickImage();
    setState(() {
      _imageBytes = imageBytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ADD PRODUCT"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Category'),
                value: _category,
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _category = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 1,
              ),
              const SizedBox(height: 10),
              _imageBytes == null
                  ? const Text('No image selected.')
                  : Image.memory(_imageBytes!, height: 100),
              TextButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitProduct,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
